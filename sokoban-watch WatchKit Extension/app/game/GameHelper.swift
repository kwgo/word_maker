//
//  GameHelper.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-16.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import Foundation
extension Data {
    var bytes : [UInt8]{
        return [UInt8](self)
    }
}
public class GameHelper {
    
    public static func loadFile(fileData : Data, offset:Int, length:Int) -> [UInt8] {
        let data =   [UInt8](fileData)
        var byteArray:[UInt8] = []
        
        for index in 0..<length {
            byteArray.append( data[index+offset])
        }
        return byteArray
    }

    public static func getPointTo(to: Point.To) -> Point.To {
        if (GameOption.instance().isPortrait()) {
            if (to == Point.To.LEFT) {
                return Point.To.UP
            } else if (to == Point.To.UP) {
                return Point.To.LEFT
            } else if (to == Point.To.RIGHT) {
                return Point.To.DOWN
            } else if (to == Point.To.DOWN) {
                return Point.To.RIGHT
            }
        }
        return to
    }
    
    public static func getPoint(bit: UInt8) -> Point {
        if (bit == 0) {
            return Point.To.RIGHT.offset()
        } else if (bit == 1) {
            return Point.To.LEFT.offset()
        } else if (bit == 2) {
            return Point.To.DOWN.offset()
        } else if (bit == 3) {
            return Point.To.UP.offset()
        }
        return Point.To.LEFT.offset()
    }
    
}

