//
//  DimeView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-10.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct DimeView<Content: View>: View {
    var clear = false
    var dimer = 0.5
    let content: () -> Content
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .opacity(self.clear ? 0.0000000001 : self.dimer)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                self.content()
            }
        }
    }
    
}

struct DimeView_Previews: PreviewProvider {
    static var previews: some View {
        DimeView() {
            Image(systemName: "bolt").foregroundColor(.red).frame(width: 150, height: 150)
        }
    }
}
