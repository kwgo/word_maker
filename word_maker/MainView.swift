//
//  MainView.swift
//  word_maker
//
//  Created by MacBook Air on 2022-11-27.
//  Copyright © 2022 JChip Games. All rights reserved.
//

import SwiftUI


struct MainView: View {
    var content: ContentView
    
    var size: CGFloat
    
    var body: some View {
        VStack() {
            WordView(word: self.getShuffledIndex(), size: self.size, action: self.doAction)
        }
    }
    
    func doAction(letter: String) {
        if(letter.isNumber()) {
            let index = Int(letter)! - 3
            WordHelper.instance().setBookIndex(index)
            let word = WordHelper.instance().getWord()
            self.content.startView(view: "game", word: word)
        }
    }
    
    func getShuffledIndex() -> String {
        var letters: [String] = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        var index = 0
        for letter in "3456789" {
            letters[index] = String(letter)
            index = index + 1
        }
        letters.shuffle()
        return letters.joined(separator: "")
    }

}


