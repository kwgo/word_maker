//
//  SlotActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI
struct SlotActivity: View {
    var content : ContentView
    
    #if !os(watchOS)
    static let BUTTON_SPACING = CGFloat(8)
    static let BUTTON_HEIGHT = CGFloat(55)
    #else
    static let BUTTON_SPACING = CGFloat(2)
    static let BUTTON_HEIGHT = CGFloat(30)
    #endif
    
    @State var showSelect = true
    @State var showErase = false
    @State var showConfirm = false
    
    @State var eraseSlot = -1
    
    var body: some View {
        _ = GameSlot.group().loadSlotGroup()
        return DimeView (clear: true) {
            ZStack {
                if showSelect {
                    VStack (spacing: SlotActivity.BUTTON_SPACING) {
                        #if !os(watchOS)
                        LabelView(label: "game_select_saved".localized)
                        #endif
                        ButtonView(title: self.getSlotTitle(slot: 0), color: self.getSlotColor(slot: 0), height: SlotActivity.BUTTON_HEIGHT) {
                            self.onGameStart(slot: 0)
                        }
                        ButtonView(title: self.getSlotTitle(slot: 1), color: self.getSlotColor(slot: 1), height: SlotActivity.BUTTON_HEIGHT) {
                            self.onGameStart(slot: 1)
                        }
                        ButtonView(title: self.getSlotTitle(slot: 2), color: self.getSlotColor(slot: 2), height: SlotActivity.BUTTON_HEIGHT) {
                            self.onGameStart(slot: 2)
                        }
                        ButtonView(title: self.getSlotTitle(slot: 3), color: self.getSlotColor(slot: 3), height: SlotActivity.BUTTON_HEIGHT) {
                            self.onGameStart(slot: 3)
                        }
                        ButtonView(title: "game_return".localized, height: SlotActivity.BUTTON_HEIGHT) {
                            self.content.startActivity(activity: "main")
                        }
                    }
                }
                if showErase {
                    VStack {
                        LabelView(label: "game_erase_saved".localized, width: nil, height: nil)
                        ButtonView(title: self.getSlotTitle(slot: 0), color: .detailColor) {
                            self.showConfirmView(slot: 0)
                        }
                        ButtonView(title: self.getSlotTitle(slot: 1), color: .detailColor) {
                            self.showConfirmView(slot: 1)
                        }
                        ButtonView(title: self.getSlotTitle(slot: 2), color: .detailColor) {
                            self.showConfirmView(slot: 2)
                        }
                        ButtonView(title: "game_return".localized) {
                            self.showSelectView()
                        }
                    }
                }
                if showConfirm {
                    VStack {
                        LabelView(label: "game_erase_confirm".localized).padding()
                        ButtonView(title: "game_erase_yes".localized, color: .detailColor) {
                            self.onEraseConfirmed()
                        }
                        ButtonView(title: "game_erase_no".localized) {
                            self.showSelectView()
                        }
                    }
                }
            }
        }
    }
    
    func getSlotColor(slot: Int) -> Color {
        return GameSlot.group().getCurrentSlot() == slot ? .detailColor : .black
    }
    
    func getSlotTitle(slot: Int) -> String {
        return slot < GameSlot.group().slotDetails.count ? GameSlot.group().slotDetails[slot] : "SLOT"
    }
    
    func onGameStart(slot: Int) {
        GameOption.instance().setCurrentSlot(currentSlot: slot)
        _ = GameSlot.instance().loadSlot()
        self.content.startActivity(activity: "game")
    }
    
    func showSelectView() {
        self.eraseSlot = -1
        self.showSelect = true
        self.showErase = false
        self.showConfirm = false
    }
    
    func showEraseView() {
        self.eraseSlot = -1
        self.showSelect = false
        self.showErase = true
        self.showConfirm = false
    }
    
    func showConfirmView(slot: Int) {
        self.eraseSlot = slot
        self.showSelect = false
        self.showErase = false
        self.showConfirm = true
    }
    
    func onEraseConfirmed() {
        if (self.eraseSlot >= 0) {
            GameOption.instance().setCurrentSlot(currentSlot: self.eraseSlot)
            GameOption.instance().setCurrentLevel(currentLevel: -1)
            _ = GameSlot.instance().eraseSlot()
        }
        GameOption.instance().setCurrentSlot(currentSlot: -1)
        self.showSelectView()
    }
}

struct SlotActivity_Previews: PreviewProvider {
    static var previews: some View {
        SlotActivity(content : ContentView())
            .background(Color.secondary)
    }
}
