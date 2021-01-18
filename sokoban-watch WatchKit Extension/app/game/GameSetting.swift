//  GameSetting.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-30.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation

public class GameSetting : Codable {
    public static let GAME_SETTING_FILE = "sokoban_collection_setting.json"
    
    private static var gameSetting: GameSetting = GameSetting()
    
    private init() {
    }
    
    func loadSetting() -> Bool {
        let paths = FileManager.default.urls (for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent(GameSetting.GAME_SETTING_FILE)
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            GameSetting.gameSetting = try jsonDecoder.decode(GameSetting.self, from: data)
            return true
        } catch {
            GameLogger.error("Failed to read Setting JSON data: \(error.localizedDescription)")
        }
        return false
    }
    
    func saveSetting() -> Bool {
        let paths = FileManager.default.urls (for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent(GameSetting.GAME_SETTING_FILE)
        if let encodedData = try? JSONEncoder().encode(self) {
            do {
                try encodedData.write(to: url)
                return true
            }
            catch {
                GameLogger.error("Failed to write Setting JSON data: \(error.localizedDescription)")
            }
        }
        return true
    }
    
    public static func instance() -> GameSetting {
        return gameSetting
    }
    
    private var floorOn = false
    private var soundOn = false
    private var musicOn = false
    private var dpadOn = true
    private var titleOn = false
    
    public func isFloorOn() -> Bool {
        return floorOn
    }
    
    public func setFloorOn(floorOn:Bool) {
        self.floorOn = floorOn
    }
    
    public func isSoundOn() -> Bool {
        return soundOn
    }
    
    public func setSoundOn(soundOn:Bool) {
        self.soundOn = soundOn
    }
    
    public func isDpadOn() -> Bool {
        return dpadOn
    }
    
    public func setDpadOn(dpadOn:Bool) {
        self.dpadOn = dpadOn
    }
    
    public func isTitleOn() -> Bool {
        return titleOn
    }
    
    public func setTitleOn(titleOn:Bool) {
        self.titleOn = titleOn
    }
    
    public func isMusicOn() -> Bool {
        return musicOn
    }
    
    public func setMusicOn(musicOn:Bool) {
        self.musicOn = musicOn
    }
    
}
