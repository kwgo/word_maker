//
//  DpadView.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-27.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI

struct DpadView: View {
    var content: GameView
    
    static let RADIUS = CGFloat(85)
    static let CIRCLE = CGFloat(30)
    static let DPAD_SIZE = CGFloat(RADIUS * 2)
    static let MOVE_BUFFER = CGFloat(20)
    
    @State var currentPosition = CGSize()
    @State var newPosition = CGSize()
    @State var isMove = false
    
    var body: some View {
        GeometryReader { geometry in
            #if !os(watchOS)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ImageView(image: "game_dpad")
                        .frame(width: DpadView.DPAD_SIZE, height: DpadView.DPAD_SIZE)
                        .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                self.currentPosition = self.getCurrentPosition(newPosition: self.newPosition, translationSize: value.translation, geometrySize: geometry.size)
                                self.isMove = self.newPosition.width - self.currentPosition.width > DpadView.MOVE_BUFFER
                                    || self.newPosition.height - self.currentPosition.height > DpadView.MOVE_BUFFER
                                self.handlePress(x: value.location.x-self.currentPosition.width-DpadView.DPAD_SIZE/2, y: value.location.y-self.currentPosition.height-DpadView.DPAD_SIZE/2)
                        }
                        .onEnded { value in
                            self.countDownTimer?.invalidate()
                            self.currentPosition = self.getCurrentPosition(newPosition: self.newPosition, translationSize: value.translation, geometrySize: geometry.size)
                            self.newPosition = self.currentPosition
                            if(!self.isMove) {
                                self.handleClick(x: value.location.x-self.currentPosition.width-DpadView.DPAD_SIZE/2, y: value.location.y-self.currentPosition.height-DpadView.DPAD_SIZE/2)
                            }
                            }
                    )
                }
            }
            #else
            VStack (spacing : 0) {
                ImageView(image: "game_arrow")
                    .frame(width: 30, height: 35).rotationEffect(.radians(-.pi/2)).opacity(0.65)
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged { _ in self.handlePress(x: 0, y: -DpadView.RADIUS) }
                        .onEnded { _ in self.countDownTimer?.invalidate()
                            self.handleClick(x: 0, y: -DpadView.RADIUS) }
                )
                Spacer()
                HStack (spacing : 0) {
                    ImageView(image: "game_arrow")
                        .frame(width: 30, height: 35).rotationEffect(.radians(.pi))
                        .opacity(0.65)//.offset(x: -4, y: 0)
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { _ in self.handlePress(x: -DpadView.RADIUS, y: 0) }
                            .onEnded { _ in self.countDownTimer?.invalidate()
                                self.handleClick(x: -DpadView.RADIUS, y: 0) }
                    )
                    Spacer()
                    ImageView(image: "game_arrow")
                        .frame(width: 30, height: 35).rotationEffect(.radians(0))
                        .opacity(0.65)//.offset(x: 4, y: 0)
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { _ in self.handlePress(x: +DpadView.RADIUS, y: 0) }
                            .onEnded { _ in self.countDownTimer?.invalidate()
                                self.handleClick(x: +DpadView.RADIUS, y: 0) }
                    )
                }
                Spacer()
                ImageView(image: "game_arrow")
                    .frame(width: 30, height: 35).rotationEffect(.radians(.pi / 2)).opacity(0.65)
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged { _ in self.handlePress(x: 0, y: +DpadView.RADIUS) }
                        .onEnded { _ in self.countDownTimer?.invalidate()
                            self.handleClick(x: 0, y: +DpadView.RADIUS) }
                )
                
            }
            #endif
        }
    }
    
    func doDpadAction(to: Point.To, action: GameControl.Action) {
        let pointTo = GameHelper.getPointTo(to: to)
        GameUtil.runOnUiThread(execute: DispatchWorkItem {
            self.content.doDpadAction(point: pointTo.offset(), action: action)
        })
    }
    
    @State var countDownTimer: GameTimer? = nil
    
    func handlePress(x: CGFloat, y: CGFloat) {
        let START_MOVE_COUNT = 8
        let TICK_INTERVAL = 0.06
        let TICK_NUMBER = 15000
        var tickCount = 0
        
        self.countDownTimer?.invalidate()
        self.countDownTimer = GameTimer(interval: TICK_INTERVAL, execute: DispatchWorkItem {
            if (self.isMove) {
                self.countDownTimer?.invalidate()
                return
            }
            if (tickCount >= START_MOVE_COUNT) {
                self.handleClick(x: x, y: y)
            }
            tickCount += 1
        }, counter: TICK_NUMBER)
    }
    
    func handleClick(x: CGFloat, y: CGFloat) {
        let theta = atan2(x, y)
        if (pow(x, 2) + pow(y, 2) <= pow(DpadView.CIRCLE, 2)) {
            self.doDpadAction(to: Point.To.UP, action: GameControl.Action.UNDO)
        } else if (pow(x, 2) + pow(y, 2) <= pow(DpadView.RADIUS, 2)) {
            if (CGFloat(-Double.pi / 4.0) <= theta && theta <= CGFloat(Double.pi / 4.0)) {
                self.doDpadAction(to: Point.To.DOWN, action: GameControl.Action.MOVE)
            } else if (CGFloat(Double.pi / 4.0) <= theta && theta <= CGFloat(3.0 * Double.pi / 4.0)) {
                self.doDpadAction(to: Point.To.RIGHT, action: GameControl.Action.MOVE)
            } else if (theta >= CGFloat(3.0 * Double.pi / 4.0) || theta <= CGFloat(-3.0 * Double.pi / 4.0)) {
                self.doDpadAction(to: Point.To.UP, action: GameControl.Action.MOVE)
            } else {
                self.doDpadAction(to: Point.To.LEFT, action: GameControl.Action.MOVE)
            }
        }
    }
    
    func getCurrentPosition (newPosition:CGSize, translationSize: CGSize, geometrySize: CGSize) -> CGSize {
        var currentPosition = CGSize()
        currentPosition.width = translationSize.width + newPosition.width
        currentPosition.height = translationSize.height + newPosition.height
        currentPosition.width = max(-geometrySize.width+DpadView.DPAD_SIZE, min(currentPosition.width, 0.0))
        currentPosition.height = max(-geometrySize.height+DpadView.DPAD_SIZE, min(currentPosition.height, 0.0))
        return currentPosition
    }
}
struct DpadView_Previews: PreviewProvider {
    static var previews: some View {
        DpadView(content: GameView(content: GameActivity(content: ContentView()))).background(Color.secondary)
    }
}
