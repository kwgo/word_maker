//
//  GameState.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-25.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation

public class GameState {
    private var track = Track()
    var pointer = 0
    
    public func initState(track: Track) {
        self.track = Track(track: track)
        pointer = 0
    }
    
    public func getMoveCount() -> Int {
        return pointer
    }
    
    public func getPushCount() -> Int {
        var num = 0
        for index in 0 ..< pointer {
            if track.getStep(pointer: index)!.isPush() {
                num += 1
            }
        }
        return num
    }
    
    public func incAction() -> Int {
        let lastStep = track.getStep(pointer: pointer-1)
        return lastStep == nil ? 0 : lastStep!.getActionId() + 1
    }
    
    public func undoStep() {
        if (pointer > 0) {
            pointer -= 1
        }
    }
    
    public func doStep(step:Step) {
        let nextRedoStep = track.getStep(pointer: pointer+1)
        if (nextRedoStep == nil || !nextRedoStep!.equals(step: step)) {
            track.addStep(pointer: pointer, step: step)
        }
        pointer += 1
    }
    
    public func getActionTrack() -> Track {
        let actionTrack = Track()
        let lastStep = track.getStep(pointer: pointer-1)
        if (lastStep != nil) {
            let actionId = lastStep!.getActionId()
            for index in stride(from: pointer - 1, through: 0, by: -1) {
                if (track.getStep(pointer: index)!.getActionId() == actionId) {
                    actionTrack.addStep(step: track.getStep(pointer: index)!)
                } else {
                    break
                }
            }
        }
        return actionTrack
    }
    
    public func getTrack() -> Track {
        return track
    }
    
    public func setTrack(track:Track) {
        self.track = track
    }
    
    public func getUndoTrack() -> Track {
        let track = Track()
        if(pointer > 0) {
            for index in stride(from: pointer - 1, through: 0, by: -1) {
                track.addStep(step: self.track.getStep(pointer: index)!)
            }
        }
        return track
    }
    
    public func getRedoTrack() ->Track {
        let track = Track()
        if(pointer < self.track.count()) {
            for index in pointer ..< self.track.count() {
                let step = self.track.getStep(pointer: index)
                if (step != nil) {
                    track.addStep(step: step!)
                }
            }
        }
        return track
    }
    
}

