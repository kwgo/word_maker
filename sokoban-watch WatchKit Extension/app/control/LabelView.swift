//
//  LabelView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct LabelView: View {
    var label = ""
    var width: CGFloat? = nil //380
    var height: CGFloat? = nil //30
    var alignment = Alignment(horizontal: .center, vertical:.center)
    var fontSize = CGFloat(28)
    var body: some View {
        Text(self.label)
            .font(Font.custom("Aldrich", size: self.fontSize))
            .foregroundColor(Color.white)
            .frame(width: width, height: height, alignment: alignment)
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView()
    }
}
