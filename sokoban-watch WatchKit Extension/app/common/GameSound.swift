//
//  GameSound.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-29.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation
import AVFoundation

public class GameSound {
    var player: AVAudioPlayer!
    
    init (source: String) {
        GameUtil.runOnThread(execute: DispatchWorkItem {
            do {
                let path = Bundle.main.path(forResource:source, ofType: nil)
                try self.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            } catch {
                GameLogger.error("File is not Loaded: \(error.localizedDescription)")
            }
        })
    }
    
    func playLoopSound(numberOfLoops: Int = -1) {
        self.playSound(numberOfLoops: numberOfLoops)
    }
    
    func playSound(numberOfLoops: Int = 1) {
        GameUtil.runOnThread(execute: DispatchWorkItem {
            self.player?.numberOfLoops = numberOfLoops
            // player?.prepareToPlay()
            self.player?.play()
        })
    }
    
    func stopSound() {
        GameUtil.runOnThread(execute: DispatchWorkItem {
            self.player?.stop()
        })
    }
}
