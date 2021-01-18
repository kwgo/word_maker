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
    
    public static let GAME_STAGE_FILE = "game_%dx88"
    
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
        let currentSlot = GameOption.instance().getCurrentSlot()
        let file = String(format: GameLoader.GAME_STAGE_FILE, currentSlot + 2)
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
