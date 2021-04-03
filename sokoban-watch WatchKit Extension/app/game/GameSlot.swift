//
//  GameSlot.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-03.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import Foundation

public class GameSlot: Codable {
    
    public static let GAME_SLOT_FILE = "sokoban_watch_slot%d.json"
    public static let GAME_SLOT_GROUP_FILE = "sokoban_watch_slot.json"

//    static public let CURRENT_LEVEL = "currentLevel"
//    static public let LIMITED_LEVEL = "limitedLevel"
//    static public let LEVEL_INDEX = "levelIndex"
//    static public let LEVEL_TRACK = "levelTrack"
//    static public let LEVEL_ANSWER = "levelAnswer"
    
    private static var gameSlot = GameSlot()
    private static var gameSlotGroup = GameSlotGroup()
    
    private init() {
    }
    
    static func instance() -> GameSlot {
        return gameSlot
    }
    
    static func group() -> GameSlotGroup {
        return gameSlotGroup
    }
    
    func loadLevel() {
        let level = GameOption.instance().getCurrentLevel()
        GameOption.instance().setTrack(track: level < levelTrack.count ? Track.valueOf(tracking: self.levelTrack[level]) : Track())
        GameLoader.instance().loadLevel()
    }
    
    func loadSlot() -> Bool {
        let currentSlot = GameOption.instance().getCurrentSlot()
        let paths = FileManager.default.urls (for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent(String(format: GameSlot.GAME_SLOT_FILE, currentSlot))
        
        GameOption.instance().setCurrentLevel(currentLevel: 0)
        GameOption.instance().setLimitedLevel(limitedLevel: 0)
        GameOption.instance().setLimitedLevel(limitedLevel: GameOption.instance().getCurrentLevel())

        self.setCurrentLevel(currentLevel: 0)
        self.setLimitedLevel(limitedLevel: 0)
        self.setLevelTrack(levelTrack: [String]())
        self.setLevelAnswer(levelAnswer: [String]())
        
        _ = GameLoader.instance().loadStage()
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            GameSlot.gameSlot = try jsonDecoder.decode(GameSlot.self, from: data)
            GameOption.instance().setCurrentLevel(currentLevel: GameSlot.gameSlot.getCurrentLevel())
            GameOption.instance().setLimitedLevel(limitedLevel: GameSlot.gameSlot.getLimitedLevel())
            return true
        } catch {
            GameLogger.error("Failed to read Slot JSON data: \(error.localizedDescription)")
        }
        return false
    }
    
    func saveSlot() -> Bool {
        let slot = GameOption.instance().getCurrentSlot()
        let level = GameOption.instance().getCurrentLevel()
        self.setCurrentLevel(currentLevel: level)
        self.setLimitedLevel(limitedLevel: GameOption.instance().getLimitedLevel())
        self.setLevelTrack(level: level, tracking: GameOption.instance().getTrack().toString())
        _ = GameSlot.group().saveSlotGroup()
        
        let paths = FileManager.default.urls (for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent(String(format: GameSlot.GAME_SLOT_FILE, slot))
        if let encodedData = try? JSONEncoder().encode(self) {
            do {
                try encodedData.write(to: url)
                return true
            }
            catch {
                GameLogger.error("Failed to write Slot JSON data: \(error.localizedDescription)")
            }
        }
        return true
    }
    
    func eraseSlot() -> Bool {
        let currentSlot = GameOption.instance().getCurrentSlot()
        let fileManager = FileManager.default
        let paths = fileManager.urls (for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent(String(format: GameSlot.GAME_SLOT_FILE, currentSlot))
        do {
            if fileManager.fileExists(atPath: url.path) {
                try fileManager.removeItem(atPath: url.path)
            }
            return GameSlot.group().eraseSlotGroup(slot: currentSlot)
        }
        catch {
            GameLogger.error("Failed to delete Slot JSON data: \(error.localizedDescription)")
        }
        return false
    }
    
    var currentLevel = 0
    func getCurrentLevel() -> Int {
        return self.currentLevel
    }
    func setCurrentLevel(currentLevel: Int)  {
        self.currentLevel = currentLevel
    }
    
    var limitedLevel = 0
    func getLimitedLevel() -> Int {
        return self.limitedLevel
    }
    func setLimitedLevel(limitedLevel: Int)  {
        self.limitedLevel = limitedLevel
    }
    
    var levelTrack = [String]()
    func getLevelTrack() -> [String] {
        return self.levelTrack
    }
    func setLevelTrack(levelTrack: [String])  {
        self.levelTrack = levelTrack
    }
    func setLevelTrack(level: Int, tracking: String)  {
        if level >= levelTrack.count {
            for _ in levelTrack.count ... level {
                levelTrack.append("")
            }
        }
        self.levelTrack[level] = tracking
    }
    var levelAnswer = [String]()
    func getLevelAnswer() -> [String] {
        return self.levelAnswer
    }
    func setLevelAnswer(levelAnswer: [String])  {
        self.levelAnswer = levelAnswer
    }
    
    public class GameSlotGroup: Codable {
        var slotDetails = ["game_slot0".localized, "game_slot1".localized, "game_slot2".localized, "game_slot3".localized, "game_slot4".localized]
        
        func setSlotDetails(details: [String]) {
            self.slotDetails = details
        }
        func getSlotDetails() -> [String] {
            return self.slotDetails
        }
        
        func setSlotDetail(slot: Int, detail: String) {
            self.slotDetails[slot] = detail
        }
        
        func getSlotDetail(slot: Int) -> String {
            return self.slotDetails[slot]
        }
        
        var currentSlot = -1
        
        func setCurrentSlot(currentSlot : Int) {
            self.currentSlot = currentSlot
        }
        
        func getCurrentSlot() -> Int {
            return self.currentSlot
        }
        
        func loadSlotGroup() -> Bool {
            let paths = FileManager.default.urls (for: .documentDirectory, in: .userDomainMask)
            let url = paths[0].appendingPathComponent(GameSlot.GAME_SLOT_GROUP_FILE)
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                GameSlot.gameSlotGroup = try jsonDecoder.decode(GameSlotGroup.self, from: data)
                return true
            } catch {
                GameLogger.error("Failed to read Slot Group JSON data: \(error.localizedDescription)")
            }
            return false
        }
        
        func saveSlotGroup() -> Bool {
            let paths = FileManager.default.urls (for: .documentDirectory, in: .userDomainMask)
            let url = paths[0].appendingPathComponent(GameSlot.GAME_SLOT_GROUP_FILE)
            
            self.currentSlot = GameOption.instance().getCurrentSlot()
            let currentLevel = GameOption.instance().getCurrentLevel()
            
            self.slotDetails[self.currentSlot] = "game_slot\(currentSlot)".localized.replacingOccurrences(of: "-0", with: "-\(currentLevel + 1)")

            if let encodedData = try? JSONEncoder().encode(self) {
                do {
                    try encodedData.write(to: url)
                    return true
                }
                catch {
                    GameLogger.error("Failed to write Slot Group JSON data: \(error.localizedDescription)")
                }
            }
            return true
        }
        
        func eraseSlotGroup(slot: Int) -> Bool {
            self.slotDetails[slot] = "game_slot\(slot)".localized
            return saveSlotGroup()
        }
    }
    
}
