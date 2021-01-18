//
//  MainActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct MainActivity: View {
    var content : ContentView
    
    #if !os(watchOS)
    static let TITLE_WIDTH = CGFloat(365)
    static let TITLE_HEIGHT = CGFloat(120)
    static let BUTTON_SPACING = CGFloat(8)
    static let BUTTON_HEIGHT = CGFloat(55)
    #else
    static let TITLE_WIDTH = CGFloat(160)
    static let TITLE_HEIGHT = CGFloat(50)
    static let BUTTON_SPACING = CGFloat(4)
    static let BUTTON_HEIGHT = CGFloat(32)
    #endif
    
    var body: some View {
        _ = GameSetting.instance().loadSetting()
        return
            DimeView (clear: true) {
                VStack (spacing: MainActivity.BUTTON_SPACING) {
                    ImageView(image: "game_title")
                        .frame(width: MainActivity.TITLE_WIDTH, height: MainActivity.TITLE_HEIGHT)
                    
                    ButtonView(title: "game_start".localized, color: .detailColor, height: MainActivity.BUTTON_HEIGHT) {
                        self.content.startActivity(activity: "slot")
                    }
                    
                    ButtonView(title: "game_setting".localized, height: MainActivity.BUTTON_HEIGHT) {
                        self.content.startActivity(activity: "setting")
                    }
                    
                    ButtonView(title: "game_help".localized,height: MainActivity.BUTTON_HEIGHT) {
                        self.content.startActivity(activity: "help")
                    }
                    
                    #if !os(watchOS)
                    ButtonView(title: "game_exit".localized, height: MainActivity.BUTTON_HEIGHT) {
                        self.onExitButton()
                    }
                    #endif
                }
            }
    }
    
    func onExitButton() {
        #if !os(watchOS)
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        #endif
        
        #if os(OSX)
        #elseif os(watchOS)
        #elseif os(tvOS)
        #elseif os(iOS)
        #if targetEnvironment(macCatalyst)
        #else
        #endif
        #endif
    }
}

struct MainActivity_Previews: PreviewProvider {
    static var previews: some View {
        MainActivity(content: ContentView()) .background(Color.secondary)
    }
}
