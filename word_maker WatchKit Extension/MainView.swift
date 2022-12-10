//
//  MainView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-25.
//

import SwiftUI

struct MainView: View {
    var content: ContentView
    
    @State var fadeIn = false
    
    var body: some View {
        VStack() {
            HStack {
                Text("Make")
                    .font(Font.custom("Aldrich", size: 32))
                    .foregroundColor(Color.titleColor)
                    .padding(.leading, 12)
                    .padding(.top, 6)
                Spacer()
            }
            HStack {
                Spacer()
                Text("a Word")
                    .font(Font.custom("Aldrich", size: 32))
                    .foregroundColor(Color.detailColor)
                    .lineLimit(1)
                    .padding(.trailing, 12)
                    .padding(.top, -16)
                    .padding(.bottom, -12)
            }
            
            Spacer()
            
            WordView(word: self.getShuffledIndex(), action: self.doAction)
                .opacity(fadeIn ? 1 : 0)
                .onAppear() {
                    withAnimation(.easeIn(duration: 5.0)) {
                        fadeIn = true
                    }
                }
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

