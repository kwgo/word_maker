//
//  GameView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-16.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct GameView: View {
    var content: GameActivity
    
    static let ANIMATION_SPEED = 60
    
    let willResignActiveNotification = NotificationCenter.default.publisher(for: NSNotification.Name.NSExtensionHostWillResignActive)
    let didBecomeActiveNotification = NotificationCenter.default.publisher(for: NSNotification.Name.NSExtensionHostDidBecomeActive)

    
    var game = GameControl()
    var gameImage = GameImage()
    var gameSound = GameSound(source: "game_sound.wav")
    
    @State var gameTitle = ""
    @State var refreshView = true
    @State var reviewStopFlag = true
    
    @State var showMenuFlag = false
    @State var showSuccessFlag = false
    @State var showSelectFlag = false
    @State var showReviewFlag = false
    @State var showTitleFlag = GameSetting.instance().isTitleOn()
    @State var showDpadFlag = GameSetting.instance().isDpadOn()
    @State var showAnswerFlag = false
    @State var showRateFlag = false
    
    func initGamePopup () -> some View {
        return ZStack {
            if self.showDpadFlag {
                DpadView(content: self)
            }
            if self.showTitleFlag {
                TitleView(content: self, title: self.$gameTitle)
            }
            if self.showReviewFlag {
                ReviewView(content: self, showStopFlag: self.$reviewStopFlag)
            }
            if self.showSuccessFlag {
                SuccessActivity(content: self)
            }
            if self.showMenuFlag {
                MenuActivity(content: self)
            }
            if self.showSelectFlag {
                SelectActivity(content: self)
            }
            if self.showAnswerFlag {
                AnswerActivity(content: self)
            }
            if self.showRateFlag {
                RateActivity(content: self)
            }
        }
    }

    var body: some View {
        return ZStack {
            self.initGameView()
            self.initGamePopup()
        }
        .onAppear {
            self.doAction(point: nil, action: GameControl.Action.REDO, singleStep: false, animate: false)
            self.checkGameSuccess(pop: false);
        }
        .onDisappear {
            self.stopAnimation.value = true
            self.saveGameStage()
        }
        .onReceive(willResignActiveNotification) {_ in
            self.stopAnimation.value = true
            self.saveGameStage()
        }
    }
    
    func initGameView () -> some View {
        DimeView (clear: true) {
            GridView(rows: self.getX(self.refreshView), columns: self.getY(self.refreshView)) { row,column in
                Image(self.getUnitImage(row, column)).resizable()
                .onTapGesture(count: 1) {
                    let point = self.getUnitPoint(row, column)
                    self.doMoveAction(point: point, action: GameControl.Action.WALK)
                }
                .onLongPressGesture(minimumDuration: 0.1) {
                    let point = self.getUnitPoint(row, column)
                    self.doMoveAction(point: point, action: GameControl.Action.PUSH)
                }
            }
        }
        .highPriorityGesture(TapGesture(count: 2).onEnded {
            self.doMoveAction(point: nil, action: GameControl.Action.BACK)
        })
        .highPriorityGesture(DragGesture().onEnded { value in
            if abs(value.startLocation.x - value.location.x) > abs(value.startLocation.y - value.location.y) {
                if value.startLocation.x < value.location.x - 24 {
                    self.showMenuFlag = true
                } else if value.startLocation.x > value.location.x + 24 {
                    self.doMoveAction(point: nil, action: GameControl.Action.BACK)
                }
            } else {
                if value.startLocation.y < value.location.y - 24 {
                    self.showTitleFlag.toggle()
                } else if value.startLocation.y > value.location.y + 24 {
                    self.showReviewFlag.toggle()
                }
            }
        })
    }
    
    private func getUnitImage(_ px: Int, _ py: Int) ->  String {
        let x = GameOption.instance().isPortrait() ? px : py
        let y = GameOption.instance().isPortrait() ? py : px
        
        let units = game.getUnits()
        let point = game.getUnitPoint(x, y)
        return gameImage.getUnitImage(units: units, x: point.x, y: point.y)
    }
    
    func getUnitPoint(_ px: Int, _ py: Int) -> Point {
        let x = GameOption.instance().isPortrait() ? px : py
        let y = GameOption.instance().isPortrait() ? py : px
        return self.game.getUnitPoint(x, y)
    }
    
    private func getX(_ : Bool) -> Int {
        return GameOption.instance().isPortrait() ? game.getFloorSize().x : game.getFloorSize().y
    }
    private func getY(_ : Bool) -> Int {
        return GameOption.instance().isPortrait() ? game.getFloorSize().y : game.getFloorSize().x
    }
    
    func loadGameStage(level: Int, restart: Bool = false, review: Bool = false) {
        self.gameImage.setCurrentStep(step: nil)
        game.loadGameStage(level: level)
        self.showGameTitle()
        if(!restart) {
            self.doAction(point: nil, action: GameControl.Action.REDO, singleStep: false, animate: false)
        }
        self.showReviewFlag = review
        self.postInvalidate()
    }
    
    func saveGameStage() {
        GameOption.instance().setTrack(track: game.getGameTrack())
        _ = GameSlot.instance().saveSlot()
    }
    
    func checkGameSuccess(pop : Bool = true) {
        let gameOption = GameOption.instance()
        GameLogger.debug("checkGameSuccess pop= ", pop)
        GameLogger.debug("checkGameSuccess level= ", gameOption.getCurrentLevel())
        GameLogger.debug("checkGameSuccess limit= ", gameOption.getLimitedLevel())
        if (gameOption.getCurrentLevel() == gameOption.getLimitedLevel()
            && gameOption.getCurrentLevel() < GameStage.STAGE_NUMBER - 1) {
            if (game.isGameSuccess()) {
                gameOption.setLimitedLevel(limitedLevel: gameOption.getCurrentLevel() + 1)
                self.saveGameStage()
                if(pop) {
                    GameUtil.runOnUiThread( execute: DispatchWorkItem { self.showSuccessFlag = true })
                }
            }
        }
    }
    
    private func showGameTitle() {
        let title = game.getGameTitle()
        GameUtil.runOnUiThread(execute: DispatchWorkItem {
            self.gameTitle = title
        })
    }
    
    public func postInvalidate() {
        GameUtil.runOnUiThread(execute: DispatchWorkItem { self.refreshView.toggle() })
    }
    
    private func playSoundEffect() {
        if (GameSetting.instance().isSoundOn()) {
            GameUtil.runOnThread(execute: DispatchWorkItem {
                self.gameSound.stopSound()
                self.gameSound.playSound()
            })
        }
    }
    
    let stopAnimation = Atomic<Bool>(true)
    public func doAction(point: Point?, action: GameControl.Action?, singleStep: Bool, animate: Bool) {
        stopAnimation.value = true
        GameUtil.startAnimation( execute: DispatchWorkItem {
            self.stopAnimation.value = false
            var playFlag = true
            var count = 0
            let track = self.game.getActionTrack(point: point, action: action, singleStep: singleStep)
            
            for step in track.getSteps() {
                count += 1
                if (animate && self.stopAnimation.value) {
                    return
                }
                if ((action == GameControl.Action.BACK || action == GameControl.Action.UNDO) ? self.game.undoStep(step: step) : self.game.moveStep(step: step)) {
                    self.gameImage.setCurrentStep(step: step)
                    if (animate) {
                        self.postInvalidate()
                        if (playFlag && count >= track.count() - 3) {
                            playFlag = false
                            self.playSoundEffect()
                        }
                        self.showGameTitle()
                        if (count != track.count()) {
                            GameUtil.sleep(millis: GameView.ANIMATION_SPEED)
                        }
                    }
                } else {
                    break
                }
            }
            self.showGameTitle()
            if (action == GameControl.Action.MOVE || action == GameControl.Action.WALK || action == GameControl.Action.PUSH) {
                self.checkGameSuccess()
            }
            GameUtil.runOnUiThread(execute: DispatchWorkItem { self.adjustLastStep() })
            GameUtil.runOnUiThread(execute: DispatchWorkItem { self.reviewStopFlag = true })
            self.postInvalidate()
        }, animate: animate)
    }
    
    @State var gameTimer: GameTimer? = nil
    func adjustLastStep() {
        let CANCEL_PUSH_TIME_SECONDS = 7.5
        self.gameTimer?.invalidate()
        let step = gameImage.getCurrentStep()
        if (step.isPush()) {
            self.gameTimer = GameTimer(interval: CANCEL_PUSH_TIME_SECONDS, execute: DispatchWorkItem {
                self.gameImage.setCurrentStep(step: Step(offset: step.getOffset(), push: false, actionId: step.getActionId()))
                self.postInvalidate()
            })
        } else {
            self.gameImage.setCurrentStep(step: game.getManLastStep(step: step))
        }
    }
    
    public func doReviewAction(action: GameControl.Action?, singleStep: Bool, animate: Bool) {
        doAction(point: nil, action: action, singleStep: singleStep, animate: animate)
    }
    
    public func doMoveAction(point: Point?, action: GameControl.Action) {
        doAction(point: point, action: action, singleStep: false, animate: true)
    }
    
    public func doDpadAction(point: Point, action: GameControl.Action) {
        doAction(point: point, action: action, singleStep: true, animate: true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(content: GameActivity(content: ContentView()))
    }
}
