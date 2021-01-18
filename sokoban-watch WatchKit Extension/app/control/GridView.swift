//
//  GridView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-16.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct GridView<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0) {
                ForEach(0 ..< self.rows, id: \.self) { row in
                    HStack (spacing: 0) {
                        ForEach(0 ..< self.columns, id: \.self) { column in
                            self.content(row, column)
                                .padding(0)
                                .listRowInsets(EdgeInsets()).aspectRatio(contentMode: .fit)
                                .frame(width: self.getSize(geometry), height: self.getSize(geometry))
                        }
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    private func getSize(_ geometry : GeometryProxy) -> CGFloat {
        let width = geometry.size.width / CGFloat(columns)
        let height = geometry.size.height / CGFloat(rows)
        return min(width.rounded(), height.rounded())
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(rows: 8,columns: 5) {rows,columns in
            Image(systemName: "bolt")
                .resizable()
            //Text ("cell(\(String(rows)), \(String(columns)))")
        }
    }
}
