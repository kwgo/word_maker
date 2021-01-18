//
//  GameActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI
import AVFoundation

struct GameActivity: View {
    var content : ContentView
    var gameSound = GameSound(source: "game_music.mp3")
    
    let willResignActiveNotification = NotificationCenter.default.publisher(for: NSNotification.Name.NSExtensionHostWillResignActive)
    let didBecomeActiveNotification = NotificationCenter.default.publisher(for: NSNotification.Name.NSExtensionHostDidBecomeActive)
    
    var body: some View {
        return ZStack {
            GameView(content: self)
        }
        .onAppear {
            GameUtil.runOnUiThread(execute: DispatchWorkItem { self.startMusic() })
        }
        .onDisappear {
            self.stopMusic()
        }
        .onReceive(didBecomeActiveNotification) { _ in
            if GameOption.instance().getCurrentSlot() < 0 {
                self.content.startActivity(activity: "main")
            } else {
                GameUtil.runOnUiThread(execute: DispatchWorkItem { self.startMusic() })
            }
        }
        .onReceive(willResignActiveNotification) { _ in
            self.stopMusic()
        }
    }
    
    func startMusic() {
        if GameSetting.instance().isMusicOn() {
            gameSound.playLoopSound()
        }
    }
    
    func stopMusic() {
        gameSound.stopSound()
    }
}

struct GameActivity_Previews: PreviewProvider {
    static var previews: some View {
        GameActivity(content: ContentView()) .background(Color.secondary)
    }
}
