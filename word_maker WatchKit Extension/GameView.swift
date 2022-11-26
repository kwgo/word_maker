//
//  GameView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-25.
//

import SwiftUI

struct GameView: View {
    var content: ContentView
    
    var word: String
    
    @State var resultWord = ""
    
    var body: some View {
        VStack() {
            WordView(word: self.getShuffledWord(), action: self.doAction)
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
        
        print ("word is ", self.word)
        print ("shuffled is ", letters.joined(separator: ""))
        return letters.joined(separator: "")
    }
}

