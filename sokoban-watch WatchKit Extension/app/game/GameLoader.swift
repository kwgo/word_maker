//
//  GameLoader.swift
//  sokoban_collection
//
//  Created by Jiang Chang on 2020-07-27.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import Foundation


import Foundation

public class Stage: Codable {
    var stage: [String]
    var answer: String
    
    func getStage() -> [String] {
        return self.stage
    }
    
    func setStage(stage: [String])  {
        self.stage = stage
    }
    
    func getAnswer() -> String {
        return self.answer
    }
    
    func setAnswer(answer: String)  {
        self.answer = answer
    }
}

public class GameLoader: Codable {
    
    public static let GAME_SLOT_0_FILE = "game_2x3x88"
    public static let GAME_SLOT_1_FILE = "game_3x4x88"
    public static let GAME_SLOT_2_FILE = "game_5x6x88"

    private static var gameLoader = GameLoader()
    
    private init() {
    }
    
    static func instance() -> GameLoader {
        return gameLoader
    }
    
    func loadLevel() {
        let level = GameOption.instance().getCurrentLevel()
        GameOption.instance().setStageMap(stageMap: stages[level].getStage())
        GameOption.instance().setAnswer(answer: Track.valueOf(tracking: stages[level].getAnswer()))
        GameOption.instance().setStageNumber(stageNumber: stages.count)
    }
    
    func loadStage() -> Bool {
        let slot = GameOption.instance().getCurrentSlot()
        let file = slot == 0 ? GameLoader.GAME_SLOT_0_FILE : (slot == 1 ? GameLoader.GAME_SLOT_1_FILE : GameLoader.GAME_SLOT_2_FILE);
        let url = Bundle.main.url(forResource: file, withExtension: "json")
        
        stages = [Stage]()
        do {
            let data = try Data(contentsOf: url!)
            let jsonDecoder = JSONDecoder()
            GameLoader.gameLoader = try jsonDecoder.decode(GameLoader.self, from: data)
            return true
        } catch {
            GameLogger.error("Failed to read Stage JSON data: \(error.localizedDescription)")
        }
        return false
    }
    
    var stages = [Stage]()
    
    func getStages() -> [Stage] {
        return self.stages
    }
    
    func setStages(stages: [Stage])  {
        self.stages = stages
    }
}
