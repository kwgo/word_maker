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
            Spacer()
            HStack {
                Image(systemName: "arrow.left")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(Color.titleColor)
                    .padding(.leading, 12)
                    .onTapGesture(count: 1) {
                        self.content.startView(view: "main", word: "")
                    }
                Spacer()
            }
            
            Text("Make a Word")
                .font(Font.custom("Aldrich", size: 48))
                .foregroundColor(Color.titleColor)
                .lineLimit(1)
                .padding(.top, 30)
                .padding(.bottom, 16)
            
            HStack {
                Text(self.getTitle())
                    .font(Font.custom("Aldrich", size: 26))
                    .foregroundColor(Color.detailColor)
                    .lineLimit(1)
                    .padding(.leading, 0)
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                
                Image(systemName: "lightbulb.circle")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(Color.titleColor)
                    .padding(.leading, 2)
                    .padding(.top, -6)
                    .onTapGesture(count: 1) {
                        self.content.startView(view: "result", word: self.word, resultWord: "[HINT]")
                    }
            }

            Spacer()
            WordView(word: self.getShuffledWord(), size: self.size, action: self.doAction)
 
            Spacer()
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
        var title = ""
        title.append(String(WordHelper.instance().getBookIndex() + 3))
        title.append(" Letters   ")
        title.append(String(WordHelper.instance().getWordIndex() + 1))
        title.append("/")
        title.append(String(WordHelper.instance().getWordCount() + 0))
        return title
    }
}


