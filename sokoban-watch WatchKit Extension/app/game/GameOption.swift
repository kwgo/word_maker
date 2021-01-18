//
//  GameOption.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-27.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import UIKit
import Foundation

public class GameOption {
    
    static public let CURRENT_LEVEL = "currentLevel"
    static public let LIMITED_LEVEL = "limitedLevel"
    static public let LEVEL_INDEX = "levelIndex"
    static public let LEVEL_TRACK = "levelTrack"
    static public let LEVEL_ANSWER = "levelAnswer"
    
    private static var gameOption = GameOption()
    
    private var stageMap = [String]()
    
    private init() {
//        orientation = UIDevice.current.orientation
    }
    
    public static func instance() -> GameOption {
        return gameOption
    }
    
//    private var orientation = UIDevice.current.orientation
//
//    public func setOrientation(orientation: UIDeviceOrientation) {
//        self.orientation = orientation
//    }
    
    public func isPortrait() -> Bool {
        #if !os(watchOS)
        var isLandscape: Bool {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        }
        return !isLandscape
        #else
        return true
        #endif
    }
    
    private var currentSlot = -1
    private var selectedLevel = 0
    private var currentLevel = 0
    private var limitedLevel = 0
    private var stageNumber = 0
    
    public func getCurrentSlot() -> Int {
        return currentSlot
    }
    
    public func setCurrentSlot(currentSlot: Int) {
        self.currentSlot = currentSlot
    }
    
    public func getCurrentLevel() -> Int {
        return currentLevel
    }
    
    public func setCurrentLevel(currentLevel:Int) {
        self.currentLevel = currentLevel
        self.setSelectedLevel(selectedLevel: currentLevel)
    }
    
    public func getLimitedLevel() -> Int {
        return limitedLevel < stageNumber ? limitedLevel : stageNumber - 1
    }
    
    public func setLimitedLevel(limitedLevel:Int) {
        self.limitedLevel = limitedLevel >= 0 ? limitedLevel : 0
    }
    
    public func getStageNumber() -> Int {
        return stageNumber
    }
    
    public func setStageNumber(stageNumber: Int) {
        self.stageNumber = stageNumber
    }
    
    public func getSelectedLevel() -> Int {
        return selectedLevel
    }
    
    public func setSelectedLevel(selectedLevel:Int) {
        self.selectedLevel = selectedLevel
    }
    
    public func getStageMap() -> [String] {
        return stageMap
    }
    
    public func setStageMap(stageMap: [String]) {
        self.stageMap = stageMap
    }
    
    private var track: Track = Track()
    
    public func getTrack() -> Track {
        return self.track
    }
    
    public func setTrack(track: Track) {
        self.track = track
    }
    
    private var answer:Track = Track()
    
    public func getAnswer() -> Track {
        return self.answer
    }
    
    public func setAnswer(answer: Track) {
        self.answer = answer
    }
}
