//
//  MainView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-25.
//

import SwiftUI

struct MainView: View {
    var content: ContentView
    
    var body: some View {
        VStack() {
            WordView(word: self.getShuffledIndex(), action: self.doAction)
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

