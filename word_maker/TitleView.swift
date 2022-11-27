//
//  TitleView.swift
//  word_maker
//
//  Created by MacBook Air on 2022-11-27.
//  Copyright © 2022 JChip Games. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    var content: ContentView
    var view: String
    var word: String
    
    var body: some View {
        VStack {
            Group {
                if "main" == self.view || "title" == self.view {
                    VStack {
                        HStack {
                            Text("Make")
                                .font(Font.custom("Aldrich", size: 80))
                                .foregroundColor(Color.titleColor)
                                .padding(.leading, 20)
                                .padding(.top, 16)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("a Word")
                                .font(Font.custom("Aldrich", size: 80))
                                .foregroundColor(Color.detailColor)
                                .lineLimit(1)
                                .padding(.trailing, 20)
                                .padding(.top, -52)
                                .padding(.bottom, 40)
                        }
                    }
                } else if "game" == self.view {
                    VStack {
                        HStack {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 30, weight: .semibold))
                                .foregroundColor(Color.titleColor)
                                .padding(.leading, 12)
                                .onTapGesture(count: 1) {
                                    self.content.startView(view: "main", word: "")
                                }
                            Spacer()
                        }
                        
                        Text("Make a Word")
                            .font(Font.custom("Aldrich", size: 50))
                            .foregroundColor(Color.titleColor)
                            .lineLimit(1)
                            .padding(.top, 30)
                            .padding(.bottom, 16)
                        
                        HStack {
                            Text(self.getTitle())
                                .font(Font.custom("Aldrich", size: 26))
                                .foregroundColor(Color.detailColor)
                                .lineLimit(1)
                                .padding(.leading, 0)
                                .padding(.top, 0)
                                .padding(.bottom, 0)
                            
                            Image(systemName: "lightbulb.circle")
                                .font(.system(size: 24, weight: .regular))
                                .foregroundColor(Color.titleColor)
                                .padding(.leading, 2)
                                .padding(.top, -6)
                                .onTapGesture(count: 1) {
                                    self.content.startView(view: "result", word: self.word, resultWord: "[HINT]")
                                }
                        }
                    }
                }
            }
        }
    }
    
    func getTitle() -> String {
        var title = ""
        title.append(String(WordHelper.instance().getBookIndex() + 3))
        title.append(" Letters   ")
        title.append(String(WordHelper.instance().getWordIndex() + 1))
        title.append("/")
        title.append(String(WordHelper.instance().getWordCount() + 0))
        return title
    }
}


