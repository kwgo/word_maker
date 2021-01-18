//
//  TextView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-02.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct TextView: View {
    var text = ""
    var color = Color.detailColor
    var top = CGFloat(3)
    var leading = CGFloat(10)
    var bottom = CGFloat(0)
    var trailing = CGFloat(10)
    var cornerRadius = CGFloat(3)
    var horizontal = HorizontalAlignment.center
    var vertical = VerticalAlignment.center
    var image = "game_bar"
    var fontSize = CGFloat(18)
    var fixedSize = true
    var closeAction: (() -> ())? = nil
    
    var body: some View {
        ZStack (alignment: Alignment(horizontal: self.horizontal, vertical: self.vertical)) {
            Image(self.image)
                .renderingMode(.original)
                .resizable()
                .cornerRadius(self.cornerRadius)
            Text(self.text)
                .font(Font.custom("Aldrich", size: self.fontSize))
                .foregroundColor(self.color)
                .fixedSize(horizontal: fixedSize, vertical: fixedSize)
                .padding(EdgeInsets(top: self.top, leading: self.leading, bottom: self.bottom, trailing: self.trailing))
                .lineSpacing(2)
            if self.closeAction != nil {
                HStack {
                    Spacer()
                    Button(action: closeAction!) {
                        Image("game_close").renderingMode(.original).frame(width: 40, height: 20)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
