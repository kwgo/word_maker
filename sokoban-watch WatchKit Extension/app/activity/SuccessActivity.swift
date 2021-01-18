//
//  SuccessActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-02.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct SuccessActivity: View {
    var content: GameView

    #if !os(watchOS)
    static let FONT_SIZE = CGFloat(40)
    #else
    static let FONT_SIZE = CGFloat(17)
    #endif
    
    var body: some View {
        DimeView {
            VStack {
                LabelView(label: "game_success_congratulation".localized, fontSize: SuccessActivity.FONT_SIZE).padding(.bottom)
                ButtonView(title: "game_success_review".localized) {
                    self.onReviewButton()
                }
                ButtonView(title: "game_success_next".localized, color: .detailColor) {
                    self.onNextButton()
                }
            }
        }
    }
    private func onReviewButton() {
        self.content.showSuccessFlag = false
        self.content.showReviewFlag = true
        self.rateGame(currentLecvel: GameOption.instance().getCurrentLevel())
    }
    private func onNextButton() {
        self.content.showSuccessFlag = false
        let currentLevel = GameOption.instance().getCurrentLevel()
        var selectedLevel = currentLevel + 1
        selectedLevel = selectedLevel < GameStage.STAGE_NUMBER ? selectedLevel : 0
        if (selectedLevel >= 0) {
            content.loadGameStage(level: selectedLevel)
            self.rateGame(currentLecvel: currentLevel)
        }
    }
    
    private func rateGame(currentLecvel: Int) {
        if [32, 80].contains(GameOption.instance().getCurrentLevel()) {
            #if !os(watchOS)
                self.content.showRateFlag = true
            #endif
        }
    }
}

struct SuccessActivity_Previews: PreviewProvider {
    static var previews: some View {
        SuccessActivity(content: GameView(content: GameActivity(content: ContentView())))
    }
}
