//
//  LetterView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-25.
//

import SwiftUI

struct LetterView: View {
    var letter: String
    var tapped: Bool
    var color: Color
    var size: CGFloat
    
    @State var pressed = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.clear)
                .frame(width: self.size, alignment: .center)
                .aspectRatio(1.0, contentMode: .fit)
            
            ZStack {
                Text(self.letter)
                //.foregroundColor(pressed ? Color.white : Color.detailColor)
                //.font(.system(size: 38, weight: .regular))
                    .frame(alignment: .center)
                    .font(Font.custom("Aldrich", size: 40))
                    //.offset(x: pressed ? -90 : 0, y: pressed ? -90 : 0)
                    .rotation3DEffect(Angle(degrees: pressed ? 20 : 0), axis: (x: 10, y: -10, z: 0))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: self.getBottomBounce(), trailing: 0))
            }
            .frame(width: self.size, height: self.size)
            .background(
                ZStack {
                    Circle()
                        .fill(self.tapped ? self.color : Color.background)
                        .frame(width: self.size - 10, height: self.size - 10)
                        .shadow(color: Color.lightShadow, radius: 2, x: -2, y: -2)
                        .shadow(color: Color.darkShadow, radius: 2, x: 2, y: 2)
                }
            )
            .scaleEffect(self.tapped ? 1.2 : 1)
        }
    }
    
    func getBottomBounce() -> CGFloat {
        if(self.letter.isNumber()) {
            return -8.0
        } else if("gpqy".contains(self.letter)) {
            return 2.0
        } else if("bdfhilt".contains(self.letter)) {
            return -6.0
        } else if("j".contains(self.letter)) {
            return -2.0
        }
        return 0.0
    }
}
