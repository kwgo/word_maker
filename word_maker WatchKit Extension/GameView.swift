//
//  GameView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-26.
//

import SwiftUI

struct GameView: View {
    var word: String
    var action: (String) -> Void?
    
    let colors: [Color] = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple, Color.pink, Color.black, Color.gray]
    
    @State var colorIndex = 0
    
    @State var circleTapped = [false, false, false, false, false, false, false, false, false]
    @State var circlePressed = false
    
    @State var tappedColors: [Color] = [Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear, Color.clear]
    
    
    let columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width / 3.5
            let numbers = self.getNumbers()
            let letters = self.getLetters()
            VStack() {
                VStack() {
                    LazyVGrid (columns: columns, alignment: .center, spacing: 0) {
                        ForEach(0 ..< 9, id: \.self) { index in
                            let letter = letters[index]
                            let color = self.getColor(index: index) //colors[self.colorIndex]
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.clear)
                                    .frame(width: size, alignment: .center)
                                    .aspectRatio(1.0, contentMode: .fit)
                                
                                ZStack {
                                    Text(letter)
                                    //.foregroundColor(circlePressed ? Color.white : Color.detailColor)
                                        .frame(alignment: .center)
                                    //.font(.system(size: 38, weight: .regular))
                                        .font(Font.custom("Aldrich", size: 40))
                                        .offset(x: circlePressed ? -90 : 0, y: circlePressed ? -90 : 0)
                                        .rotation3DEffect(Angle(degrees: circlePressed ? 20 : 0), axis: (x: 10, y: -10, z: 0))
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: -8, trailing: 0))
                                }
                                .frame(width: size, height: size)
                                .background(
                                    ZStack {
                                        Circle()
                                            .fill(circleTapped[index] ? color : Color.background)
                                            .frame(width: size - 10, height: size - 10)
                                            .shadow(color: Color.lightShadow, radius: 2, x: -2, y: -2)
                                            .shadow(color: Color.darkShadow, radius: 2, x: 2, y: 2)
                                    }
                                )
                                .scaleEffect(circleTapped[index] ? 1.2 : 1)
                                
                                
                                .onTapGesture(count: 1) {
                                    print("letter=", letter)
                                    
                                    if(!self.circleTapped[index]) {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            self.doAction(letter: letter)
                                        }
                                    }
                                    self.tappedColors[index] = self.colors[self.colorIndex]
                                    self.circleTapped[index] = true
                                }
                            }
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
    print("colorIndex ===", colorIndex)
        self.action(letter)
    }
    
    func getColor(index: Int) -> Color {
        print("XXX  colorIndex ===", colorIndex, " tapped=", circleTapped[index])
        return circleTapped[index] ? self.tappedColors[index] : self.colors[self.colorIndex]
    }
    
    func getNumbers()  -> [Int]{
        var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        numbers.shuffle()
        print("numbers =", numbers)
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
