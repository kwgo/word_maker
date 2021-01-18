//
//  GameControl.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import Foundation

public class GameControl {
    var game = GameAction()
    var stage = GameStage()
    var state = GameState()
    
    init() {
         self.loadGameStage(level: GameOption.instance().getCurrentLevel())
    }
    
    func getUnitPoint(_ x:Int, _ y:Int) -> Point {
        let offset = self.stage.getFloorOffset()
        return Point(x: x+offset.x, y: y+offset.y)
    }
    
    func getFloorSize() -> Point {
        return self.stage.getFloorSize()
    }
    
    func getUnits() -> [[Unit]] {
        return self.stage.getUnits()
    }
    
    public func loadGameStage(level: Int) {
        let gameOption = GameOption.instance()
        gameOption.setCurrentLevel(currentLevel: level)
        GameSlot.instance().loadLevel()
        self.stage.initStage(level: level, stageMap: gameOption.getStageMap(), stageNumber: gameOption.getStageNumber())
        self.state.initState(track: GameOption.instance().getTrack())
        self.game.initAction(stage: self.stage, state: self.state)
    }
    
    func isGameSuccess() -> Bool {
        return self.stage.isSuccess()
    }
    
    func getGameTitle() -> String {
        let level = GameOption.instance().getCurrentLevel()
        let numMove = state.getMoveCount()
        let numPush =  state.getPushCount()
        return String(format: "game_title_bar".localized, level + 1, numMove, numPush)
    }
    
    func getGameTrack() -> Track {
        let gameTrack = Track()
        let track = self.state.getTrack()
        for pointer in 0 ... self.state.getMoveCount() {
            let step = track.getStep(pointer: pointer)
            if step != nil {
                gameTrack.addStep(step: step!)
            }
        }
        return gameTrack
    }
    
    func moveStep (step: Step) -> Bool {
        return self.game.move(step: step)
    }
    
    func undoStep (step: Step) -> Bool {
        return self.game.undo(step: step)
    }
    
    func getManLastStep(step: Step) ->Step {
        if (!step.isPush()) {
            let man = stage.getMan()
            var countBox = 0, countWall = 0
            var face: Point? = nil
            for offset in Point.directions() {
                let point = man.move(offset: offset)
                if (stage.getUnit(position: point).isBox()) {
                    countBox += 1
                    face = offset
                }
                if (stage.getUnit(position: point).isWall()) {
                    countWall += 1
                }
            }
            if (countBox == 1 && countWall == 2) {
                return Step(offset: face!, push: false, actionId: step.getActionId())
            }
        }
        return step
    }
    
    func getActionTrack(point:Point?, action:Action?, singleStep:Bool) -> Track {
        var track: Track?
        if (action == Action.UNDO || action == Action.REDO) {
            track = (action == Action.UNDO) ? state.getUndoTrack() : state.getRedoTrack()
        } else if (action == Action.WALK) {
            track = game.getWalkTrack(target: point!)
        } else if (action == Action.PUSH) {
            track = game.getPushTrack(target: point!)
        } else if (action == Action.BACK) {
            track = game.getBackTrack()
        } else if (action == Action.MOVE) {
            track = game.getMoveTrack(offset: point!)
        }
        track = track == nil ? Track() : track
        if (singleStep) {
            if track != nil && track!.count() > 0 {
                var steps = [Step] ()
                steps.append(track!.getStep(pointer: 0)!)
                track = Track(steps: steps)
            }
        }
        return (track == nil ? Track() : track)!
    }
    
    public enum Action {
        case BACK, MOVE, WALK, PUSH, UNDO, REDO
    }
}
