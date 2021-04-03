//
//  SelectActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-02.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct SelectActivity: View {
    var content : GameView
    
    #if !os(watchOS)
    static let BUTTON_SIZE = CGFloat(90)
    static let GRIDS_SIZE = CGFloat(300)
    #else
    static let BUTTON_SIZE = CGFloat(50)
    static let GRIDS_SIZE = CGFloat(180)
    #endif
    
    static let GRID_NUMBER = 3
    static let PAGE_NUMBER = GRID_NUMBER * GRID_NUMBER
    
    @State var pageIndex = 0
    
    var body: some View {
        DimeView {
            ArrowView (onLeftArrow: { self.onLeftPage() }, onRightArrow: { self.onRightPage() }) {
                GridView(rows: SelectActivity.GRID_NUMBER, columns: SelectActivity.GRID_NUMBER) { row,column in
                    ButtonView(title: self.getButtonLabel(row: row, column: column), image: "game_select",
                               color: self.getButtonColor(row: row, column: column), width: SelectActivity.BUTTON_SIZE, height: SelectActivity.BUTTON_SIZE) {
                                self.onSelectButton(row: row, column: column)
                    }
                }
                    .frame(width: SelectActivity.GRIDS_SIZE, height: SelectActivity.GRIDS_SIZE)
            }
        }
        .gesture(DragGesture()
        .onEnded { value in
            if value.startLocation.x < value.location.x - 24 {
                self.onLeftPage()
            } else if value.startLocation.x > value.location.x + 24 {
                self.onRightPage()
            }
        })
    }
    
    func onLeftPage() {
        self.pageIndex -= 1
        self.pageIndex = self.pageIndex % (GameOption.instance().getStageNumber() / SelectActivity.PAGE_NUMBER + 1)
    }
    
    func onRightPage() {
        self.pageIndex += 1
        self.pageIndex = self.pageIndex % (GameOption.instance().getStageNumber() / SelectActivity.PAGE_NUMBER + 1)
    }
    
    func getSelectedLevel(row: Int, column: Int) -> Int {
        let gameOption = GameOption.instance()
        let currentLevel = gameOption.getCurrentLevel()
        let stageNumber = gameOption.getStageNumber()
        let index = row * SelectActivity.GRID_NUMBER + column
        let indexLevel = (currentLevel + pageIndex * SelectActivity.PAGE_NUMBER + (index - SelectActivity.PAGE_NUMBER / 2) + stageNumber) % stageNumber
        
        return indexLevel
    }
    
    func getButtonLabel(row: Int, column: Int) -> String {
        let selectedLevel = self.getSelectedLevel(row: row, column: column)
        return selectedLevel >= 0 ? String(selectedLevel + 1) : ""
    }
    
    func getButtonColor(row: Int, column: Int) -> Color {
        let gameOption = GameOption.instance()
        let currentLevel = gameOption.getCurrentLevel()
        //let limitedLevel = gameOption.getLimitedLevel()
        let limitedLevel = gameOption.getStageNumber()
        let selectedLevel = self.getSelectedLevel(row: row, column: column)
        if (selectedLevel == currentLevel) {
            return Color.white
        } else if (selectedLevel > limitedLevel) {
            return Color.black
        }
        return Color.detailColor
    }
    
    func onSelectButton(row: Int, column: Int) {
        let gameOption = GameOption.instance()
        let limitedLevel = gameOption.getStageNumber()
        let selectedLevel = self.getSelectedLevel(row: row, column: column)
        if (selectedLevel >= 0 && selectedLevel <= limitedLevel) {
            self.content.showSelectFlag = false
            if (selectedLevel != gameOption.getCurrentLevel()) {
                gameOption.setLimitedLevel(limitedLevel: selectedLevel)
                self.content.saveGameStage()
                self.content.loadGameStage(level: selectedLevel)
           }
        }
    }
}

struct SelectActivity_Previews: PreviewProvider {
    static var previews: some View {
        SelectActivity(content: GameView(content: GameActivity(content: ContentView())))
    }
}
