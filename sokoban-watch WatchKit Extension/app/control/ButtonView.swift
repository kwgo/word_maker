//
//  ButtonView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    #if !os(watchOS)
    static let BUTTON_WIDTH = CGFloat(360)
    static let BUTTON_HEIGHT = CGFloat(55)
    static let FONT_SIZE = CGFloat(24)
    #else
    static let BUTTON_WIDTH = CGFloat(160)
    static let BUTTON_HEIGHT = CGFloat(36)
    static let FONT_SIZE = CGFloat(18)
    #endif
    
    var title = ""
    var image = "game_bar"
    var color = Color.black
    var width = BUTTON_WIDTH
    var height = BUTTON_HEIGHT
    var cornerRadius = 5
    var action:() -> Void
    
    var body: some View {
        VStack (spacing: 0) {
            Button(action: action) {
                ZStack {
                    Image(self.image)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: self.width, height: self.height)
                        .cornerRadius(CGFloat(self.cornerRadius))
                    if(title.count > 0) {
                        Text(self.title)
                            .font(Font.custom("Aldrich", size: ButtonView.FONT_SIZE))
                            .foregroundColor(self.color)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }.buttonStyle(PlainButtonStyle())
        }
    }
    
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "button") {}
    }
}
