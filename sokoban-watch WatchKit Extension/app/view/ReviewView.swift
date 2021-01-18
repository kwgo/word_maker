//
//  ReviewView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-27.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct ReviewView: View {
    var content: GameView
    
    #if !os(watchOS)
    static let BUTTON_NUMBER = CGFloat(7)
    static let BUTTON_HEIGHT = CGFloat(32)
    #else
    static let BUTTON_NUMBER = CGFloat(5)
    static let BUTTON_HEIGHT = CGFloat(18)
    #endif
    
    @Binding var showStopFlag: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack (spacing: 0) {
                    ButtonView(image: "review_button_start", width: geometry.size.width/ReviewView.BUTTON_NUMBER, height: ReviewView.BUTTON_HEIGHT) {
                        self.showStopFlag = false
                        self.reviewAction(action: ReviewView.Action.START)
                    }.padding(0)
                    ButtonView(image: "review_button_rewind", width: geometry.size.width/ReviewView.BUTTON_NUMBER, height: ReviewView.BUTTON_HEIGHT) {
                        self.showStopFlag = false
                        self.reviewAction(action: ReviewView.Action.REWIND)
                    }.padding(0)
                    #if !os(watchOS)
                    ButtonView(image: "review_button_back", width: geometry.size.width/ReviewView.BUTTON_NUMBER, height: ReviewView.BUTTON_HEIGHT) {
                        self.showStopFlag = true
                        self.reviewAction(action: ReviewView.Action.BACK)
                    }.padding(0)
                    #endif
                    if !self.showStopFlag {
                        ButtonView(image: "review_button_pause", width: geometry.size.width/ReviewView.BUTTON_NUMBER, height: ReviewView.BUTTON_HEIGHT) {
                            self.showStopFlag = true
                            self.reviewAction(action: ReviewView.Action.PAUSE)
                        }.padding(0)
                    } else {
                        ButtonView(image: "review_button_stop", width: geometry.size.width/ReviewView.BUTTON_NUMBER, height: ReviewView.BUTTON_HEIGHT) {
                            self.showStopFlag = true
                            self.content.showReviewFlag = false
                         }.padding(0)
                    }
                    #if !os(watchOS)
                    ButtonView(image: "review_button_move", width: geometry.size.width/ReviewView.BUTTON_NUMBER, height: ReviewView.BUTTON_HEIGHT) {
                        self.showStopFlag = true
                        self.reviewAction(action: ReviewView.Action.MOVE)
                    }.padding(0)
                    #endif
                    ButtonView(image: "review_button_forward", width: geometry.size.width/ReviewView.BUTTON_NUMBER, height: ReviewView.BUTTON_HEIGHT) {
                        self.showStopFlag = false
                        self.reviewAction(action: ReviewView.Action.FORWARD)
                    }.padding(0)
                    ButtonView(image: "review_button_end", width: geometry.size.width/ReviewView.BUTTON_NUMBER, height: ReviewView.BUTTON_HEIGHT) {
                        self.showStopFlag = true
                        self.reviewAction(action: ReviewView.Action.END)
                    }.padding(0)
                }.frame (width: geometry.size.width, height: ReviewView.BUTTON_HEIGHT)
            }
        }
    }
    
    func reviewAction(action: ReviewView.Action) {
        switch action {
        case ReviewView.Action.START:
            content.doReviewAction(action: GameControl.Action.UNDO, singleStep: false, animate: false)
        case ReviewView.Action.REWIND:
            content.doReviewAction(action: GameControl.Action.UNDO, singleStep: false, animate: true)
        case ReviewView.Action.BACK:
            content.doReviewAction(action: GameControl.Action.UNDO, singleStep: true, animate: false)
        case ReviewView.Action.MOVE:
            content.doReviewAction(action: GameControl.Action.REDO, singleStep: true, animate: false)
        case ReviewView.Action.FORWARD:
            content.doReviewAction(action: GameControl.Action.REDO, singleStep: false, animate: true)
        case ReviewView.Action.END:
            content.doReviewAction(action: GameControl.Action.REDO, singleStep: false, animate: false)
        case ReviewView.Action.PAUSE:
            content.doReviewAction(action: nil, singleStep: false, animate: false)
        default:
            break
        }
    }
    
    public enum Action: String {
        case START, REWIND, BACK, PAUSE, STOP, MOVE, FORWARD, END
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(content: GameView(content: GameActivity(content: ContentView())),
                   showStopFlag: Binding.constant(true)) .background(Color.secondary)
    }
}

