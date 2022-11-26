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
                .frame(alignment: .center)
                .font(.system(size: 40, weight: .regular))
                .offset(x: circlePressed ? -90 : 0, y: circlePressed ? -90 : 0)
                .rotation3DEffect(Angle(degrees: circlePressed ? 20 : 0),
                                        axis: (x: 10, y: -10, z: 0))
            }
            .frame(width: self.size, height: self.size)
            .background(
                ZStack {
                    Circle()
                        .fill(circleTapped ? self.color : Color("Background"))
                        .frame(width: self.size - 20, height: self.size - 20)
                        .shadow(color: Color("LightShadow"), radius: 8, x: -8, y: -8)
                        .shadow(color: Color("DarkShadow"), radius: 8, x: 8, y: 8)
                }
            )
            .scaleEffect(circleTapped ? 1.2 : 1)
            .onTapGesture(count: 1) {
                self.circleTapped.toggle()
                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // self.circleTapped = false
                //}
            }
        }
    }

}
