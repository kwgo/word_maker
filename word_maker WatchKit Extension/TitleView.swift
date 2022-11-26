//
//  TitleView.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-26.
//

import SwiftUI

struct TitleView: View {
    var content: ContentView
    var view: String
    var word: String
    
    var body: some View {
        HStack {
            Group {
                if "main" == self.view {
                    VStack {
                        Text("Make")
                            .font(Font.custom("Aldrich", size: 36))
                            .padding(.leading, 10)
                            .padding(.top, 0)
                        Text("a Word")
                            .font(Font.custom("Aldrich", size: 30))
                            .padding(.leading, 60)
                            .padding(.top, -20)
                            .foregroundColor(Color.detailColor)
                        
                    }
                } else if "game" == self.view {
                    HStack {
                        //  Spacer(length: 15)
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                            .padding(.top, -10)
                            .onTapGesture(count: 1) {
                                self.content.startView(view: "main", word: "")
                            }
                        Text(self.getTitle())
                            .font(Font.custom("Aldrich", size: 18))
                            .foregroundColor(Color.detailColor)
                            .padding(.leading, 2)
                            .padding(.top, -6)
                            .onTapGesture(count: 1) {
                                self.content.startView(view: "result", word: self.word, resultWord: "[" + self.word + "]")
                            }
                    }
                }
            }
            Spacer()
        }
        .frame( height: 50, alignment: .leading)
       
    }
    
    func getTitle() -> String {
        var title = "W"
        title.append(String(WordHelper.instance().getBookIndex() + 3))
        title.append(" ")
        title.append(String(WordHelper.instance().getWordIndex() + 1))
        title.append("/")
        title.append(String(WordHelper.instance().getWordCount() + 0))
        return title
    }
}

