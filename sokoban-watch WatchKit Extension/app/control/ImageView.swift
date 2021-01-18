//
//  ImageView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    var image:String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .resizable()
            .padding(0)
            //.scaledToFill()
           // .scaledToFit()
            //.aspectRatio(contentMode: .fit)
            //.listRowInsets(EdgeInsets())
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(image: "view_box")
    }
}
