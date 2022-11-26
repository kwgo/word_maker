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
        
    @State var tappedStatus: [Bool] = [false, false, false, false, false, false, false, false, false]
    @State var tappedColors: [Color] = [Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear]
    @State var colorIndex = 0
    
    
    let columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        let letters = self.getLetters()
        GeometryReader { geometry in
            VStack() {
                VStack() {
                    LazyVGrid (columns: columns, alignment: .center, spacing: 0) {
                        ForEach(0 ..< 9, id: \.self) { index in
                            LetterView(letter: letters[index], tapped: self.tappedStatus[index], color: self.tappedColors[index], size: geometry.size.width / 3.5)
                            
                                .id(UUID())
                                .onTapGesture(count: 1) {
                                    if(!self.tappedStatus[index]) {
                                        self.tappedStatus[index] = true
                                        self.tappedColors[index] = self.colors[self.colorIndex]
                                        self.colorIndex = (self.colorIndex + 1) % 9
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            self.doAction(letter: letters[index])
                                        }
                                    }
                                }
                        }
                    }
                    .padding(0)
                }
            }
        }
    }
    
    func doAction(letter: String) {
        print("letter=", letter)

        self.action(letter)
    }
    
//    func getNumbers()  -> [Int]{
//        var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
//        numbers.shuffle()
//        return numbers
//    }
    
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
