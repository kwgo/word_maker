//
//  GameAction.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-25.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation

public class GameAction {
    
    private var stage: GameStage!
    private var state: GameState!
    
    public func initAction (stage: GameStage, state: GameState) {
        self.stage = stage
        self.state = state
    }
    
    public func move(step: Step!) -> Bool {
        if (step != nil) {
            let offset = step.getOffset()
            let man = stage.getMan()
            let pace = man.move(offset: step.getOffset())
            if (stage.getUnit(position: pace).isFloor()) {
                if (stage.getUnit(position: pace).isBox()) {
                    let next = pace.move(offset: offset)
                    if (!stage.getUnit(position: next).isWall() && !stage.getUnit(position: next).isBox()) {
                        stage.getUnit(position: man).setMan(man: false)
                        stage.getUnit(position: pace).setMan(man: true)
                        stage.getUnit(position: pace).setBox(box: false)
                        stage.getUnit(position: next).setBox(box: true)
                        stage.setMan(man: pace)
                        state.doStep(step: Step(offset: step.getOffset(), push: true, actionId: step.getActionId()))
                        return true
                    }
                } else {
                    stage.getUnit(position: man).setMan(man: false)
                    stage.getUnit(position: pace).setMan(man: true)
                    stage.setMan(man: pace)
                    state.doStep(step: Step(offset: step.getOffset(), push: false, actionId: step.getActionId()))
                    return true
                }
            }
        }
        return false
    }
    
    public func getMoveTrack(offset: Point) -> Track? {
        let actionId = state.incAction()
        let pace = stage.getMan().move(offset: offset)
        if (stage.getUnit(position: pace).isFloor()) {
            let track = Track()
            if (stage.getUnit(position: pace).isBox()) {
                let span = pace.move(offset: offset)
                if (!stage.getUnit(position: span).isWall() && !stage.getUnit(position: span).isBox()) {
                    track.addStep(step: Step(offset: offset, push: true, actionId: actionId))
                    return track
                }
            } else {
                track.addStep(step: Step(offset: offset, push: false, actionId: actionId))
                return track
            }
        }
        return nil
    }
    
    public func undo(step: Step!) -> Bool {
        if (step != nil) {
            let offset = step.getOffset()
            let man = stage.getMan()
            let pace = man.move(offset: Point(x: -offset.x, y: -offset.y))
            if (stage.getUnit(position: pace).isWalkable()) {
                stage.getUnit(position: pace).setMan(man: true)
                stage.getUnit(position: man).setMan(man: false)
                if (step.isPush()) {
                    stage.getUnit(position: man).setBox(box: true)
                    let next = man.move(offset: offset)
                    stage.getUnit(position: next).setBox(box: false)
                }
                stage.setMan(man: pace)
                state.undoStep()
                return true
            }
        }
        return false
    }
    
    public func getBackTrack() -> Track? {
        return state.getActionTrack()
    }
    
    public func getWalkTrack(target: Point) -> Track? {
        if (stage.getUnit(position: target).isWalkable()) {
            let actionId = state.incAction()
            let directions = Point.directions()
            var numbers = [Int]()
            var positions = [Point]()
            numbers.append(0)
            positions.append(stage.getMan())
            var foundPath = false
            var number = 0
            var index = 0
            while (index <= number) {
                let position = positions[index]
                for offset in directions {
                    let pace = position.move(offset: offset)
                    let unit = stage.getUnit(position: pace)
                    if (!(positions.contains(pace)) && !unit.isWall() && !unit.isBox() && !unit.isMan()) {
                        number += 1
                        positions.append(pace)
                        numbers.append(numbers[index] + 1)
                        if (target.equals(point: pace)) {
                            foundPath = true
                            break
                        }
                    }
                }
                if (foundPath) {
                    break
                }
                index += 1
            }
            if (foundPath) {
                var reverse:[Step] = [Step]()
                var director = 0
                var number = numbers.last! - 1
                var position = positions.last!
                while (number >= 0) {
                    let offset:Point = directions[director]
                    let pace = position.move(offset: offset)
                    let index = positions.firstIndex(of: pace) ?? -1
                    if index >= 0 && number == numbers[index] {
                        reverse.append(Step(offset: offset, push: false, actionId: actionId))
                        position = position.move(offset: offset)
                        number -= 1
                        continue
                    }
                    director = (director+1) % directions.count
                }
                let track:Track = Track()
                for index in (0 ..< reverse.count).reversed() {
                    let offset:Point = reverse[index].getOffset()
                    track.addStep(step: Step(offset: Point(x: -offset.x, y: -offset.y), push: false, actionId: actionId))
                }
                return track
            }
        }
        return nil
    }
    
    public func getPushTrack(target: Point) -> Track? {
        if (stage.getUnit(position: target).isWalkable()) {
            let actionId = state.incAction()
            let track = Track()
            var pace = stage.getMan()
            let offset = Point(x: 0, y: 0)
            if (target.x == pace.x) {
                offset.y = target.y > pace.y ? +1 : -1
            } else if (target.y == stage.getMan().y) {
                offset.x = target.x > pace.x ? +1 : -1
            } else {
                return nil
            }
            var hasBox = false
            repeat {
                pace = pace.move(offset: offset)
                if (stage.getUnit(position: pace).isWall()) {
                    return nil
                }
                if (stage.getUnit(position: pace).isBox()) {
                    if (hasBox) {
                        return nil
                    }
                    hasBox = true
                }
                if (!pace.equals(point: target)) {
                    track.addStep(step: Step(offset: offset, push: hasBox, actionId: actionId))
                }
            } while (!pace.equals(point: target))
            if (!hasBox) {
                return nil
            }
            return track
        }
        return nil
    }
}
