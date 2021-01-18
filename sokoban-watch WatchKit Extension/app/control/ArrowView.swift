//
//  ImageView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct ArrowView<Content: View>: View {
    var onLeftArrow:() -> Void
    var onRightArrow:() -> Void
    var content: () -> Content
    
    var body: some View {
        HStack (spacing: 2) {
            #if !os(watchOS)
            Button(action: self.onLeftArrow) {
                Image("game_arrow_left").renderingMode(.original).padding(0)
            }.buttonStyle(PlainButtonStyle())
            self.content().padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 1)
            )
            Button(action: self.onRightArrow) {
                Image("game_arrow_right").renderingMode(.original).padding(0)
            }.buttonStyle(PlainButtonStyle())
            #else
            self.content()
            #endif
        }
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView (onLeftArrow: {}, onRightArrow: {} ) {
            ImageView(image: "view_box").padding()
            
        }
        .background(Color.black)
    }
}
