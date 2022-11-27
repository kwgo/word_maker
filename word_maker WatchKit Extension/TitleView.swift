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
                        HStack {
                            Text("Make")
                                .font(Font.custom("Aldrich", size: 32))
                                .foregroundColor(Color.titleColor)
                                .padding(.leading, 10)
                                .padding(.top, 6)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("a Word")
                                .font(Font.custom("Aldrich", size: 32))
                                .foregroundColor(Color.detailColor)
                                .lineLimit(1)
                                .padding(.trailing, 10)
                                .padding(.top, -16)
                                .padding(.bottom, -12)
                        }
                    }
                } else if "game" == self.view {
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .padding(.leading, 2)
                            .padding(.top, 4)
                            .onTapGesture(count: 1) {
                                self.content.startView(view: "main", word: "")
                            }
                        Text(self.getTitle())
                            .font(Font.custom("Aldrich", size: 16))
                            .foregroundColor(Color.detailColor)
                            .padding(.leading, 0)
                            .padding(.top, 2)
                            .padding(.bottom, -4)
                            .onTapGesture(count: 1) {
                                self.content.startView(view: "result", word: self.word, resultWord: "[HINT]")
                            }
                    }
                    .padding(10)
                } else if "result" == self.view {
                    Spacer()
                }
            }
            Spacer()
        }
    }
    
    func getTitle() -> String {
        var title = "L"
        title.append(String(WordHelper.instance().getBookIndex() + 3))
        title.append("-")
        title.append(String(WordHelper.instance().getWordIndex() + 1))
        title.append("/")
        title.append(String(WordHelper.instance().getWordCount() + 0))
        return title
    }
}

