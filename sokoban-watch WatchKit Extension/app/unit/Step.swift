//
//  Step.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-25.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation

public class Step {
    
    private let push : Bool
    private let offset : Point
    private let actionId : Int
    
    public init (offset:Point, push : Bool,  actionId:Int) {
        self.offset = offset
        self.push = push
        self.actionId = actionId
    }
    
    public func isPush() -> Bool {
        return push
    }
    
    func getOffset() -> Point {
        return offset
    }
    
    public func getActionId() -> Int {
        return actionId
    }
    
    public  func equals(step:Step) -> Bool {
        return actionId == step.actionId && push == step.push && offset.equals(point: step.offset)
    }
    
    public static func valueOf(steping: String) -> Step? {
        var index = 0
        for ch in Array(steping) {
            if ch.isLetter {
                let actionId = GameUtil.parse(value: steping.substring(from: 0, to: index), defaultValue: 0)
                let isPush = (ch == "R" || ch == "U" || ch == "L" || ch == "D")
                let point = Point.valueOf(pointing: ch)
                return point == nil ? nil : Step(offset: point!, push: isPush, actionId: actionId)
            }
            index += 1
        }
        return nil
    }
    
    public func toString() -> String {
        return String(actionId) + (push ? offset.toString().uppercased() : offset.toString())
    }
}
