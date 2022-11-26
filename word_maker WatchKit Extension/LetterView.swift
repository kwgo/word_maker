//
//  LetterView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-25.
//

import SwiftUI

struct LetterView: View {
    var text: String
    var color: Color
    var size: CGFloat
    
    @State var circleTapped = false
    @State var circlePressed = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.clear)
                .frame(width: self.size, alignment: .center)
                .aspectRatio(1.0, contentMode: .fit)
            
            ZStack {
                Text(self.text)
                    //.foregroundColor(circlePressed ? Color.white : Color.detailColor)
                    .frame(alignment: .center)
                    //.font(.system(size: 38, weight: .regular))
                    .font(Font.custom("Aldrich", size: 40))
                    .offset(x: circlePressed ? -90 : 0, y: circlePressed ? -90 : 0)
                    .rotation3DEffect(Angle(degrees: circlePressed ? 20 : 0), axis: (x: 10, y: -10, z: 0))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -8, trailing: 0))
            }
            .frame(width: self.size, height: self.size)
            .background(
                ZStack {
                    Circle()
                        .fill(circleTapped ? self.color : Color.background)
                        .frame(width: self.size - 10, height: self.size - 10)
                        .shadow(color: Color.lightShadow, radius: 2, x: -2, y: -2)
                        .shadow(color: Color.darkShadow, radius: 2, x: 2, y: 2)
                }
            )
            .scaleEffect(circleTapped ? 1.2 : 1)


            .onTapGesture(count: 1) {
                self.circleTapped.toggle()
                print("word=ffff")
          
                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // self.circleTapped = false
                //}
            }
        }
    }
    
}
