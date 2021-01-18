//
//  TitleView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-27.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    var content: GameView
    @Binding var title: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                #if !os(watchOS)
                TextView (text: self.title) { self.onCloseButton() }
                    .frame (width: geometry.size.width, height:30)
                #else
                LabelView(label: self.title, fontSize: 14).padding(8).frame (width: geometry.size.width, height:24)
                #endif
                Spacer()
            }
        }
    }
    
    private func onCloseButton() {
        GameSetting.instance().setTitleOn(titleOn: false)
        self.content.showTitleFlag = false
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(content: GameView(content: GameActivity(content: ContentView())),
                  title: .constant("title")).background(Color.secondary)
    }
}
