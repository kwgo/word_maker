//
//  Point.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-25.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation


public class Point: Equatable {
    var x = 0
    var y = 0
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
 
    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.equals(point: rhs)
    }
    
    public func move(offset: Point) -> Point {
        return Point(x: x + offset.x, y: y + offset.y)
    }
    
    public static func directions() -> [Point] {
        return [
            Point(x:-1, y:0), Point(x:0, y:-1),
            Point(x:+1, y:0), Point(x:0, y:+1)
        ]
    }
    
    public func equals(point: Point) -> Bool {
        return x == point.x && y == point.y
    }
    
    public enum To {
        case LEFT, UP, RIGHT, DOWN
        func offset() -> Point {
            switch self {
            case .LEFT: return Point(x:-1, y:0)
            case .UP: return Point(x:0, y:-1)
            case .RIGHT: return Point(x:+1, y:0)
            case .DOWN: return Point(x:0, y:+1)
            }
        }
    }
    
    public static func valueOf(pointing: Character) -> Point? {
        if (pointing == "R" || pointing == "r") {
            return Point.To.RIGHT.offset()
        } else if (pointing == "U" || pointing == "u") {
            return Point.To.UP.offset()
        } else if (pointing == "D" || pointing == "d") {
            return Point.To.DOWN.offset()
        } else if (pointing == "L" || pointing == "l") {
            return Point.To.LEFT.offset()
        } else {
            return nil
        }
    }
    
    public func toString() -> String {
        if (self == To.LEFT.offset()) {
            return "l"
        } else if (self == To.RIGHT.offset()) {
            return "r"
        } else  if (self == To.UP.offset())  {
            return "u"
        } else if (self == To.DOWN.offset()) {
            return "d"
        }
        return "\(x),\(y)"
    }
    
    public var description: String { return self.toString() }
}
