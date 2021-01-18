//
//  GameUtil.swift
//  boxman
//
//  Created by Jiang Chang on 2020-05-27.
//  Copyright © 2020 JChip Software. All rights reserved.
//

import Foundation

public class GameUtil {
    public static func bytesToHex(bytes: [UInt8]) -> String {
        let HEX_ARRAY:[Character] = [Character] (arrayLiteral: "0", "1","2","3","4","5","6","7","8","9","A","B","C","D","E","F")//123456789ABCDEF".toCharArray()
        var hexChars:[Character] = [Character]() //[bytes.length * 2]
        for j in 0 ..< bytes.count {
            let v:UInt8 = bytes[j] & 0xFF
            hexChars[j * 2] = HEX_ARRAY[Int(v) >> 4]
            hexChars[j * 2 + 1] = HEX_ARRAY[Int(v) & 0x0F]
        }
        return String(hexChars)
    }
    
    public static func sleep(millis: Int) {
        usleep(useconds_t(Double(1000) * Double(millis)))
    }
    
    public static func isNullOrEmpty(value: String?) -> Bool {
        return value == nil || value!.isEmpty
    }
    
    public static func parse(value: String, defaultValue: Int) -> Int {
        return Int(value) ?? defaultValue
    }
    
    public static func parse(value: String, defaultValue: Float) -> Float {
        return Float(value) ?? defaultValue
    }
    
    private static var animationDispatchQueue = DispatchQueue(label: "animation")
    public static func startAnimation(execute animationTask: DispatchWorkItem, animate: Bool) {
        animationDispatchQueue.async {
            animationTask.perform()
        }
    }
    
    public static func runOnUiThread(execute task: DispatchWorkItem) {
        DispatchQueue.main.async {
            task.perform()
        }
    }
    
    public static func runOnThread(execute task: DispatchWorkItem) {
        DispatchQueue(label: "threads").async {
            task.perform()
        }
    }
}

