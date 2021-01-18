//
// Unit.swift
// boxman
//
// Created by Jiang Chang on 2020-05-22.
// Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation

public class Unit {
    private var man = false
    private var box = false
    private var dot = false
    private var wall = false
    private var floor = false
    
    public init (position: Point) {
        self.position = position
    }
    
    public func isMan() -> Bool {
        return man
    }
    public func setMan(man: Bool) {
        self.man = man
    }
    
    public func isBox() -> Bool {
        return box
    }
    
    public func setBox(box: Bool) {
        self.box = box
    }
    
    public func isDot() -> Bool {
        return dot
    }
    
    public func setDot(dot: Bool) {
        self.dot = dot
    }
    
    public func isWall() -> Bool {
        return wall
    }
    
    public func setWall(wall: Bool) {
        self.wall = wall
    }
    
    public func isFloor() -> Bool{
        return floor
    }
    
    public func setFloor(floor: Bool) {
        self.floor = floor
    }
    
    public func isGround()->Bool {
        return !man && !box && !dot && !wall && !floor
    }
    
    public func isWalkable() ->Bool {
        return !man && !box && !wall && floor
    }
    
    public func isEmpty() ->Bool {
        return floor && !man && !box && !dot && !wall
    }
    
    private var position: Point
    
    func getPosition()->Point{
        return position
    }
    
    public enum Symbol: Int {
        case GROUND=0, WALL=1, BOX=2, FLOOR=3, DOT=4, BOX_DOT=5, MAN=6, MAN_DOT=7
        
        func getIndex() -> Int {
            return self.rawValue
        }
        
        func getSymbol() -> Character {
            switch self {
            case .GROUND: return " "
            case .WALL: return "#"
            case .BOX: return "$"
            case .FLOOR: return " "
            case .DOT: return "."
            case .BOX_DOT: return "*"
            case .MAN: return "@"
            case .MAN_DOT: return "+"
            }
        }
    }
    
    public static func getSymbolAA(character: Character) -> Symbol {
        if (character == Symbol.WALL.getSymbol()) {
            return Symbol.WALL
        } else if (character == Symbol.BOX_DOT.getSymbol()) {
            return Symbol.BOX_DOT
        } else if (character == Symbol.BOX.getSymbol()) {
            return Symbol.BOX
        } else if (character == Symbol.MAN_DOT.getSymbol()) {
            return Symbol.MAN_DOT
        } else if (character == Symbol.MAN.getSymbol()) {
            return Symbol.MAN
        } else if (character == Symbol.DOT.getSymbol()) {
            return Symbol.DOT
        }
        return Symbol.GROUND
    }
    
    
    public func getSymbol() -> Symbol {
        if wall {
            return Symbol.WALL
        } else if box && dot {
            return Symbol.BOX_DOT
        } else if (box) {
            return Symbol.BOX
        } else if (man && dot) {
            return Symbol.MAN_DOT
        } else if (man) {
            return Symbol.MAN
        } else if (dot) {
            return Symbol.DOT
        } else if (floor) {
            return Symbol.FLOOR
        }
        return Symbol.GROUND
    }
    
    func toString() ->String {
        return String(self.getSymbol().getSymbol())
    }
}
