//
//  WordView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-25.
//

import SwiftUI

struct WordView: View {
    var word: String
    var action: (String) -> Void?
    
    let colors: [Color] = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple, Color.pink, Color.black, Color.gray]
    
    @State var colorIndex = 0
    
    
    let columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                VStack() {
                    let numbers = self.getNumbers()
                    let letters = self.getLetters()
                    LazyVGrid (columns: columns, alignment: .center, spacing: 0) {
                        ForEach(0 ..< 9, id: \.self) { index in
                            let letter = letters[numbers[index]]
                            let color = colors[numbers[index]]
                            LetterView(letter: letter, color: color, size: geometry.size.width / 3.5, action: self.doAction)
                                .id(UUID())
                        }
                    }
                    .padding(0)
                }
            }
        }
    }
    
    func doAction(letter: String) {
        self.colorIndex = (self.colorIndex + 1) % 9
    
        self.action(letter)
    }
    
    func getNumbers()  -> [Int]{
        var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        numbers.shuffle()
        return numbers
    }
    
    func getLetters()  -> [String]{
        var letters: [String] = ["", "", "", "", "", "", "", "", ""]
        var index = 0
        for char in word {
            letters[index] = String(char)
            index = index + 1
        }
        return letters
    }
}
