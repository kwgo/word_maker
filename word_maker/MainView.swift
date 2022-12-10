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
    
    @State var fadeIn = false
    
    var body: some View {
        VStack() {
            Spacer()
            HStack {
                Text("Make")
                    .font(Font.custom("Aldrich", size: 80))
                    .foregroundColor(Color.titleColor)
                    .padding(.leading, 20)
                    .padding(.top, 16)
                Spacer()
            }
            HStack {
                Spacer()
                Text("a Word")
                    .font(Font.custom("Aldrich", size: 80))
                    .foregroundColor(Color.detailColor)
                    .lineLimit(1)
                    .padding(.trailing, 20)
                    .padding(.top, -52)
                    .padding(.bottom, 40)
            }
            
            Spacer()
            WordView(word: self.getShuffledIndex(), size: self.size, action: self.doAction)
                .opacity(fadeIn ? 1 : 0)
                .onAppear() {
                    withAnimation(.easeIn(duration: 5.0)) {
                        fadeIn = true
                    }
                }
            Spacer()
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


