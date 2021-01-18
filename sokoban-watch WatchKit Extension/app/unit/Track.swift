//
//  Track.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-25.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation

public class Track {
    private var steps = [Step]()
    
    public init () {
    }
    
    public init(track: Track!) {
        if (track != nil) {
            let steps = track.getSteps()
            for step in steps {
                self.addStep(step: step)
            }
        }
    }
    
    public init (steps: [Step]!) {
        if (steps != nil) {
            for step in steps {
                self.addStep(step: step)
            }
        }
    }
    
    public func getSteps() -> [Step] {
        return steps
    }
    
    public func addStep(step: Step) {
        steps.append(step)
    }
    
    public func count() -> Int {
        return steps.count
    }
    
    public func addStep(pointer: Int, step: Step) {
        let size = steps.count
        if (pointer >= 0 && pointer < size) {
            let nextStep = getStep(pointer: pointer)
            if (nextStep != nil && nextStep!.getOffset().equals(point: step.getOffset())) {
                steps[pointer] = step
                return
            }
            steps.removeSubrange(pointer ..< size)
        }
        steps.append(step)
    }

    public func getStep(pointer: Int) -> Step? {
        return pointer >= 0 && pointer < steps.count ? steps[pointer] : nil
    }

    public static func valueOf(tracking: String) -> Track {
        let track = Track()
        var stepCount = 0
        var start = -1, end = -1
        var index = 0
        let characters = Array(tracking)
        for ch in characters {
            if ch.isNumber {
                start = start >= 0 ? start : index
            } else {
                end = index
                var steping = ""
                if (start >= 0 && end > start) {
                    for offset in start ... end {
                        steping.append(characters[offset])
                    }
                    start = -1
                } else {
                    steping.append(ch)
                }
                let step = Step.valueOf(steping: steping)
                if step != nil {
                    track.addStep(step: step!)
                } else {
                    return track
                }
                stepCount += 1
            }
            index += 1
        }
        return track
    }
    
    public func toString() -> String {
        var sb = ""
        for step in steps {
            sb.append(step.toString())
        }
        return sb
    }
    
}
