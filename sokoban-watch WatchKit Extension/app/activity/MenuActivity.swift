//
//  MenuActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-25.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct MenuActivity: View {
    var content: GameView
    
    #if !os(watchOS)
    static let BUTTON_SPACING = CGFloat(8)
    static let BUTTON_HEIGHT = CGFloat(55)
    #else
    static let BUTTON_SPACING = CGFloat(2)
    static let BUTTON_HEIGHT = CGFloat(30)
    #endif

    var body: some View {
        DimeView {
            VStack (spacing: MenuActivity.BUTTON_SPACING) {
                ButtonView(title: "game_resume".localized, color: .detailColor, height: MenuActivity.BUTTON_HEIGHT) {
                    self.onReturnButton()
                }
                ButtonView(title: "game_restart".localized, height: MenuActivity.BUTTON_HEIGHT) {
                    self.onReturnButton()
                    self.content.loadGameStage(level: GameOption.instance().getCurrentLevel(), restart: true)
                }
                ButtonView(title: "game_answer".localized, height: MenuActivity.BUTTON_HEIGHT) {
                    self.onReturnButton()
                    //#if !os(watchOS)
                    //self.content.showAnswerFlag = true
                    //#else
                    self.loadAnswerTrack()
                    //#endif
                }
                ButtonView(title: "game_select_level".localized, height: MenuActivity.BUTTON_HEIGHT) {
                    self.onReturnButton()
                    self.content.showSelectFlag = true
                }
                ButtonView(title: "game_return_menu".localized, height: MenuActivity.BUTTON_HEIGHT) {
                    self.onReturnButton()
                    self.content.content.content.startActivity(activity: "main")
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

    func onReturnButton() {
        self.content.showMenuFlag = false
    }
}

struct MenuActivity_Previews: PreviewProvider {
    static var previews: some View {
        MenuActivity(content: GameView(content: GameActivity(content: ContentView())))
    }
}
