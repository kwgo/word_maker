//
//  GameLogger.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-27.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation

public class GameLogger {
    public static func debug(_ items: Any...) {
        debugPrint(items)
    }
    
    public static func info(_ message:String) {
        NSLog("%s", message)
    }
    
    public static func warn(_ message:String) {
        NSLog("%s", message)
    }
    
    public static func error(_ message:String) {
        NSLog("%s", message)
    }
}
