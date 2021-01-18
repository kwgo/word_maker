//
//  ContentView.swift
//  sokoban_collection
//
//  Created by Jiang Chang on 2020-07-26.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func charAt(_ index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur += 1
        }
        return nil
    }
    
    func indexOf(_ character: Character) -> Int {
        var index = 0
        for char in self {
            if char == character {
                return index
            }
            index += 1
        }
        return -1
    }
    
    func lastIndexOf(_ character: Character) -> Int {
        var index = 0
        for char in self.reversed() {
            if char == character {
                return index
            }
            index += 1
        }
        return -1
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(from: Int, to: Int) -> String {
        let fromIndex = index(from: from)
        let toIndex = index(from: to)
        return String(self[fromIndex..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

extension Color {
    public static var detailColor: Color { return Color(0xd5883c) }
    init(_ hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct ContentView: View {
    
    @State var activity = "main"
    
    
    #if !os(watchOS)
    static let edgeSet = Edge.Set()
    #else
    static let edgeSet = Edge.Set.bottom
    #endif

    
    var body: some View {
            ZStack {
                Image("game_background").resizable().edgesIgnoringSafeArea(.all)
                if "main" == self.activity {
                    MainActivity(content: self)//.edgesIgnoringSafeArea(ContentView.edgeSet)
                } else if "slot" == self.activity {
                    SlotActivity(content: self)//.edgesIgnoringSafeArea(ContentView.edgeSet)
                } else if "game" == self.activity {
                    #if !os(watchOS)
                    Color(.black).edgesIgnoringSafeArea(.all)
                    Image("game_background").resizable()
                    GameActivity(content: self)
                    #else
                    GameActivity(content: self)//.edgesIgnoringSafeArea(ContentView.edgeSet)
                    #endif
                } else if "setting" == self.activity {
                    SettingActivity(content: self)//.edgesIgnoringSafeArea(ContentView.edgeSet)
                } else if "help" == self.activity {
                    HelpActivity(content: self)//.edgesIgnoringSafeArea(ContentView.edgeSet)
                }
            }.edgesIgnoringSafeArea(ContentView.edgeSet)
    }
    
    func startActivity(activity:String) {
        self.activity = activity
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
