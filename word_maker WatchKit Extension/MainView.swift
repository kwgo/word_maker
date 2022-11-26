//
//  MainView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-25.
//

import SwiftUI

struct MainView: View {
    var content : ContentView
        
    var body: some View {
        VStack() {
            GameView(word: "3456789", action: self.doAction)
        }
    }
    
    
    func doAction(word: String) {
        print("word=", word)
  
    }

}

