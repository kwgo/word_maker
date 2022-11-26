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
            WordView(word: "3456789", action: self.onButton)
        }
    }
    
    
    func onButton(word: String) {
        print("word=", word)
  
    }

}

