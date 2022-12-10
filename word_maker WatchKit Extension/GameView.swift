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
            HStack {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20))
                    .padding(.leading, 2)
                    .padding(.top, 4)
                    .onTapGesture(count: 1) {
                        self.content.startView(view: "main", word: "")
                    }
                Text(self.getTitle())
                    .font(Font.custom("Aldrich", size: 16))
                    .foregroundColor(Color.detailColor)
                    .padding(.leading, 0)
                    .padding(.top, 2)
                    .padding(.bottom, -4)
                    .onTapGesture(count: 1) {
                        self.content.startView(view: "result", word: self.word, resultWord: "[HINT]")
                    }
                Spacer()
            }
            .padding(10)

            Spacer()
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
        return letters.joined(separator: "")
    }
    
    func getTitle() -> String {
        var title = "L"
        title.append(String(WordHelper.instance().getBookIndex() + 3))
        title.append("-")
        title.append(String(WordHelper.instance().getWordIndex() + 1))
        title.append("/")
        title.append(String(WordHelper.instance().getWordCount() + 0))
        return title
    }
}
