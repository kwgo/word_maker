//
//  ResultView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-26.
//

import SwiftUI

struct ResultView: View {
    var content : ContentView
    
    var word: String
    var resultWord: String
    
    var body: some View {
        let success = self.isSuccess()
        let hint = self.isHint()
        let count = hint ? self.word.count : self.resultWord.count
        VStack {
            Text(hint ? self.word : self.resultWord)
                .frame(alignment: .center)
                .font(Font.custom("Aldrich", size: count < 8 ? 40 : 36))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -10, trailing: 0))
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
            
            Image(success ? "game_success" : hint ? "game_hint" : "game_fail")
                .renderingMode(.original)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .padding(20)
                .onTapGesture(count: 1) {
                    self.onContinue(success: success)
                }
        }
    }
    
    func isSuccess() -> Bool {
        let success = self.resultWord == self.word
        if(!success) {
            let words = WordHelper.instance().getWords()
            for word in words {
                if(word == self.resultWord) {
                    return true
                }
            }
        }
        return success
    }
    
    func isHint() -> Bool {
        return "[HINT]" == self.resultWord
    }
    
    func onContinue(success: Bool) {
        WordHelper.instance().setWordIndex(next: success)
        
        let word = WordHelper.instance().getWord()
        self.content.startView(view: "game", word: word)
    }
}

