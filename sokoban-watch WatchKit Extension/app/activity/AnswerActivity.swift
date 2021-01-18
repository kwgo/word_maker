//
//  AnswerActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-02.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct AnswerActivity: View {
    var content: GameView

    var body: some View {
        return DimeView {
            VStack {
                LabelView(label: String(format: "game_answer_info".localized, GameOption.instance().getCurrentLevel() + 1))
                    .padding(.bottom)
                ButtonView(title: "game_answer_ok".localized, color: .detailColor) {
                    self.onAnswerButton()
                }
                ButtonView(title: "game_return".localized) {
                    self.onReturnButton()
                }
            }
        }
    }
    
    func loadAnswerTrack() {
        let answer =  GameOption.instance().getAnswer()
        if (answer.count() > 0) {
            if (GameOption.instance().getCurrentLevel() == GameOption.instance().getLimitedLevel() && GameOption.instance().getCurrentLevel() < GameStage.STAGE_NUMBER - 1) {
                GameOption.instance().setLimitedLevel(limitedLevel: GameOption.instance().getCurrentLevel() + 1)
            }
            GameOption.instance().setTrack(track: answer)
            _ = GameSlot.instance().saveSlot()
            self.content.loadGameStage(level: GameOption.instance().getCurrentLevel(), restart: false, review: true)
        }
    }
    
    private func onAnswerButton() {
        #if !os(watchOS)
        GameRewarded.instance().showAd(rewardFunction: {
            self.onReturnButton()
            self.loadAnswerTrack()
        })
        #endif
    }
    
    private func onReturnButton() {
        self.content.showAnswerFlag = false
    }
}

struct AnswerActivity_Previews: PreviewProvider {
    static var previews: some View {
        AnswerActivity(content: GameView(content: GameActivity(content: ContentView())))
    }
}
