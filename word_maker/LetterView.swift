//
//  LetterView.swift
//  word_maker
//
//  Created by MacBook Air on 2022-11-27.
//  Copyright © 2022 JChip Games. All rights reserved.
//

import SwiftUI

struct LetterView: View {
    var letter: String
    var tapped: Bool
    var color: Color
    var size: CGFloat
    
    @State var pressed = false
    
    var body: some View {
        let aspectRatio = self.getAspectRatio()
        ZStack {
            Rectangle()
                .foregroundColor(Color.clear)
                .frame(width: self.size, alignment: .center)
                .aspectRatio(aspectRatio, contentMode: .fit)
            
            ZStack {
                Text(self.letter)
                    .foregroundColor(Color.letterColor)
                    .font(Font.custom("Aldrich", size: 70))
                    .frame(alignment: .center)
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
            return -12.0
        } else if("gpqy".contains(self.letter)) {
            return 6.0
        } else if("bdfhiklt".contains(self.letter)) {
            return -6.0
        } else if("j".contains(self.letter)) {
            return -2.0
        }
        return 0.0
    }
    
    func getAspectRatio() -> CGFloat {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let isLandscape = UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height
        return isPad && isLandscape ? 2.0 : 1.0
    }
}
