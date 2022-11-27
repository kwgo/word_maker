//
//  GameView.swift
//  word_maker
//
//  Created by MacBook Air on 2022-11-27.
//  Copyright © 2022 JChip Games. All rights reserved.
//

import SwiftUI

struct GameView: View {
    var content: ContentView
    
    var word: String
    var size: CGFloat

    @State var resultWord = ""
    
    var body: some View {
        VStack() {
            WordView(word: self.getShuffledWord(), size: self.size, action: self.doAction)
        }
    }
    
    func doAction(letter: String) {
        if("[HINT]" == letter) {
            self.content.startView(view: "result", word: self.word, resultWord: "[HINT]")
        } else {
            self.resultWord.append(contentsOf: letter)
            if(self.resultWord.count == self.word.count) {
                self.content.startView(view: "result", word: self.word, resultWord: self.resultWord)
            }
        }
    }
    
    func getShuffledWord() -> String {
        var letters: [String] = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        var index = 0
        for char in word {
            letters[index] = String(char)
            index = index + 1
        }
        letters.shuffle()
        return letters.joined(separator: "")
    }
}


