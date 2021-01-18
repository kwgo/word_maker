//
//  GameStage.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-25.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation

public class GameStage {
    public static var STAGE_NUMBER = 0
    
    public static var STAGE_WIDTH = 32
    public static var STAGE_HEIGHT = 20
        
    private var man = Point(x: 0, y: 0)
    private var units = [[Unit]]()
    //(repeating: [Unit](repeating: Unit(position: Point(x:0, y:0)), count: STAGE_WIDTH), count: STAGE_HEIGHT)
    private var blocks = [UInt8]()
    
    private var level = 0
    private var shape = 2
    
    private var floorLeftTop = Point(x: GameStage.STAGE_WIDTH, y: GameStage.STAGE_HEIGHT)
    private var floorRightBottom = Point(x: 0, y: 0)
    
    private func getStageShape(stageMap: [String]) -> Int {
        var start = 99, end = 0
        for row in stageMap {
            var off = row.indexOf(Unit.Symbol.WALL.getSymbol())
            start = start < off ? start : off
            off = row.lastIndexOf(Unit.Symbol.WALL.getSymbol())
            end = end > off ? end : off
        }
        
        let maxWidth = end - start + 1
        var length = stageMap[0].count
        start = 99
        end = 0
        for x in 0 ..< length {
            for y in 0 ..< stageMap.count {
                length = length >= stageMap[y].count ? length : stageMap[y].count
                if (x < stageMap[y].count && stageMap[y].charAt(x) == Unit.Symbol.WALL.getSymbol()) {
                    start = start < y ? start : y
                    end = end > y ? end : y
                }
            }
        }
        let maxHeight = end - start + 1
        let shapeWidth = (maxWidth + 7) / 8
        let shapeHeight = (maxHeight + 4) / 5
        let shape = shapeWidth > shapeHeight ? shapeWidth : shapeHeight
        return shape
    }
    
    public func getUnit(position:Point) -> Unit {
        return units[position.x][position.y]
    }
    
    public func getMan() -> Point {
        return man
    }
    
    public func getShape() -> Int {
        return shape
    }
    
    public func setMan(man: Point) {
        self.man = man
    }
    
    public func initStage(level: Int, stageMap: [String], stageNumber: Int) {
        self.shape = getStageShape(stageMap: stageMap)
        
        GameStage.STAGE_NUMBER = stageNumber
        GameStage.STAGE_WIDTH = shape * 8
        GameStage.STAGE_HEIGHT = shape * 5
        
        self.units = Array(repeating: Array(repeating: Unit(position: Point(x: 0,y: 0)), count: GameStage.STAGE_HEIGHT), count: GameStage.STAGE_WIDTH)
        
        for y in 0 ..< GameStage.STAGE_HEIGHT {
            for x in 0 ..< GameStage.STAGE_WIDTH {
                let position : Point = Point(x: x, y: y)
                units[x][y] = Unit(position: position)
            }
        }
        
        self.loadStage(stageMap: stageMap)
    }
    
    private func loadStage(stageMap: [String]) {
        let dx = 0, dy = 0
        for y in 0 ..< stageMap.count {
            for x in 0 ..< stageMap[y].count {
                let symbol = Unit.getSymbolAA(character: stageMap[y].charAt(x)!)
                if (symbol == Unit.Symbol.WALL) {
                    units[dx + x][dy + y].setWall(wall: true)
                }
                if (symbol == Unit.Symbol.BOX || symbol == Unit.Symbol.BOX_DOT) {
                    units[dx + x][dy + y].setBox(box: true)
                }
                if (symbol == Unit.Symbol.DOT || symbol == Unit.Symbol.BOX_DOT || symbol == Unit.Symbol.MAN_DOT) {
                    units[dx + x][dy + y].setDot(dot: true)
                }
                if (symbol == Unit.Symbol.MAN || symbol == Unit.Symbol.MAN_DOT) {
                    units[dx + x][dy + y].setMan(man: true)
                    man = Point(x: dx + x, y: dy + y)
                }
            }
        }
        self.setFloorInfo()
        self.markFloor(position: man)
    }
    
    private func markFloor(position: Point) {
        let unit:Unit = units[position.x][position.y]
        if (!unit.isWall() && !unit.isFloor()) {
            unit.setFloor(floor: true)
            for offset in Point.directions() {
                markFloor(position: position.move(offset: offset))
            }
        }
    }
    
    public func getUnits() -> [[Unit]] {
        return self.units
    }
    
    public func setFloorInfo() {
        self.floorLeftTop = Point(x: GameStage.STAGE_WIDTH, y: GameStage.STAGE_HEIGHT)
        self.floorRightBottom = Point(x: 0, y: 0)
        for y in 0 ..< shape * 5 {
            for x in 0 ..< shape * 8 {
                if (units[x][y].isWall()) {
                    floorLeftTop.x = x < floorLeftTop.x ? x : floorLeftTop.x
                    floorLeftTop.y = y < floorLeftTop.y ? y : floorLeftTop.y
                    floorRightBottom.x = x > floorRightBottom.x ? x : floorRightBottom.x
                    floorRightBottom.y = y > floorRightBottom.y ? y : floorRightBottom.y
                }
            }
        }
    }
    
    public func  getFloorOffset() -> Point {
        return self.floorLeftTop
    }
    
    public func getFloorSize() -> Point {
        let x = floorRightBottom.x - floorLeftTop.x + 1
        let y = floorRightBottom.y - floorLeftTop.y + 1
        return Point(x: x<0 ? 0:x, y: y<0 ? 0:y)
    }
    
    public func isSuccess() -> Bool {
        for y in 0 ..< shape * 5 {
            for x in 0 ..< shape * 8 {
                if (units[x][y].isBox() && !units[x][y].isDot()) {
                    return false
                }
            }
        }
        return true
    }
    
    public func toString() -> String {
        var builder:String = ""
        for y in 0 ..< GameStage.STAGE_HEIGHT {
            builder.append("\n")
            for x in 0 ..< GameStage.STAGE_WIDTH {
                builder.append(units[x][y].getSymbol().getSymbol())
            }
        }
        return builder
    }
}
