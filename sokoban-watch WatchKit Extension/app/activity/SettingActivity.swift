//
//  MainActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct SettingActivity: View {
    var content : ContentView
    
    #if !os(watchOS)
    static let BUTTON_SPACING = CGFloat(8)
    static let BUTTON_HEIGHT = CGFloat(55)
    #else
    static let BUTTON_SPACING = CGFloat(2)
    static let BUTTON_HEIGHT = CGFloat(30)
    #endif
    
    @State private var isMusicOn = GameSetting.instance().isMusicOn()
    @State private var isSoundOn = GameSetting.instance().isSoundOn()
    @State private var isFloorOn = GameSetting.instance().isFloorOn()
    @State private var isTitleOn = GameSetting.instance().isTitleOn()
    @State private var isDpadOn = GameSetting.instance().isDpadOn()
    
    var body: some View {
        DimeView (clear: true) {
            VStack (spacing: SettingActivity.BUTTON_SPACING) {
                #if !os(watchOS)
                ButtonView (title: ("setting_music" + (self.isMusicOn ? "_on":"_off")).localized, color: (self.isMusicOn ? .detailColor:.black), height: SettingActivity.BUTTON_HEIGHT) { self.isMusicOn.toggle() }.padding(.top)
                #endif
                ButtonView (title: ("setting_sound" + (self.isSoundOn ? "_on":"_off")).localized, color: (self.isSoundOn ? .detailColor:.black), height: SettingActivity.BUTTON_HEIGHT) { self.isSoundOn.toggle()
                    #if os(watchOS)
                    self.isMusicOn = self.isSoundOn
                    #endif
                }
                ButtonView (title: ("setting_title" + (self.isTitleOn ? "_on":"_off")).localized, color: (self.isTitleOn ? .detailColor:.black), height: SettingActivity.BUTTON_HEIGHT) { self.isTitleOn.toggle() }
                ButtonView (title: ("setting_floor" + (self.isFloorOn ? "_on":"_off")).localized, color: (self.isFloorOn ? .detailColor:.black), height: SettingActivity.BUTTON_HEIGHT) { self.isFloorOn.toggle() }
                ButtonView (title: ("setting_dpad"  + (self.isDpadOn  ? "_on":"_off")).localized, color: (self.isDpadOn ? .detailColor:.black), height: SettingActivity.BUTTON_HEIGHT) { self.isDpadOn.toggle()  }
                ButtonView(title: "game_return".localized, height: SettingActivity.BUTTON_HEIGHT) {
                    GameSetting.instance().setMusicOn(musicOn: self.isMusicOn)
                    GameSetting.instance().setSoundOn(soundOn: self.isSoundOn)
                    GameSetting.instance().setFloorOn(floorOn: self.isFloorOn)
                    GameSetting.instance().setTitleOn(titleOn: self.isTitleOn)
                    GameSetting.instance().setDpadOn(dpadOn: self.isDpadOn)
                    _ = GameSetting.instance().saveSetting()
                    self.content.startActivity(activity: "main")
                }
            }
        }
    }
}

struct SettingActivity_Previews: PreviewProvider {
    static var previews: some View {
        SettingActivity(content: ContentView()).background(Color.secondary)
    }
}
