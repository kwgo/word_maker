//
//  WordView.swift
//  word_maker
//
//  Created by MacBook Air on 2022-11-27.
//  Copyright © 2022 JChip Games. All rights reserved.
//

import SwiftUI

struct WordView: View {
    var word: String
    var size: CGFloat
    var action: (String) -> Void?
    
    let columns = [GridItem(), GridItem(), GridItem()]
    
    let colors: [Color] = [Color.red, Color.orangeColor, Color.yellow, Color.green, Color.cyanColor, Color.blue, Color.pinkColor, Color.brownColor, Color.purple]
    
    @State var tappedStatus: [Bool] = [false, false, false, false, false, false, false, false, false]
    @State var tappedColors: [Color] = [Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear]
    @State var colorIndex = 0
    
    var body: some View {
        let letters = self.getLetters()
        VStack() {
            VStack() {
                LazyVGrid (columns: columns, alignment: .center, spacing: 0) {
                    ForEach(0 ..< 9, id: \.self) { index in
                        LetterView(letter: letters[index], tapped: self.tappedStatus[index], color: self.tappedColors[index], size: self.size)
                            .id(UUID())
                            .onTapGesture(count: 1) {
                                if(!self.tappedStatus[index] && !letters[index].trim().isEmpty) {
                                    withAnimation {
                                        self.tappedStatus[index] = true
                                        self.tappedColors[index] = self.colors[self.colorIndex]
                                        self.colorIndex = (self.colorIndex + 1) % 9
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        self.action(letters[index])
                                    }
                                }
                            }
                            .onLongPressGesture(minimumDuration: 0.1) {
                                if(letters[index].isLetter()) {
                                    self.action("[HINT]")
                                }
                            }
                    }
                }
            }
        }
    }
    
    func getLetters()  -> [String] {
        var letters: [String] = ["", "", "", "", "", "", "", "", ""]
        var index = 0
        for char in word {
            letters[index] = String(char)
            index = index + 1
        }
        return letters
    }
}
