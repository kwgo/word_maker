//
//  HelpActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-13.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI
import StoreKit

struct HelpActivity: View {
    var content : ContentView
    
    #if !os(watchOS)
    static let CONTENT_WIDTH = CGFloat(310)
    static let TITLE_HEIGHT = CGFloat(36)
    static let TITLE_SPACING = CGFloat(3)
    static let IMAGE_HEIGHT = CGFloat(140)
    static let DETAIL_HEIGHT = CGFloat(110)
    static let DETAIL_SPACING = CGFloat(20)
    static let BUTTON_SPACING = CGFloat(8)
    static let FONT_SIZE = CGFloat(18)
    #else
    static let CONTENT_WIDTH = CGFloat(164)
    static let TITLE_HEIGHT = CGFloat(24)
    static let TITLE_SPACING = CGFloat(1)
    static let IMAGE_HEIGHT = CGFloat(76)
    static let DETAIL_HEIGHT = CGFloat(60)
    static let DETAIL_SPACING = CGFloat(8)
    static let BUTTON_SPACING = CGFloat(2.5)
    static let FONT_SIZE = CGFloat(14)
    #endif
    
    @State var pageIndex: Int = 0 //Page.allCases.count - 1
    
    var body: some View {
        DimeView (clear : true) {
            ArrowView (onLeftArrow: { self.onLeftPage() }, onRightArrow: { self.onRightPage() }) {
                VStack (spacing: HelpActivity.BUTTON_SPACING) {
                    TextView(text: self.getTitle(), color: .white, top: HelpActivity.TITLE_SPACING, horizontal: .leading, fontSize: HelpActivity.FONT_SIZE) { self.onCloseButton() }
                        .frame (width: CGFloat(HelpActivity.CONTENT_WIDTH), height: HelpActivity.TITLE_HEIGHT)
                    
                    ZStack {
                        Rectangle()
                            .opacity(0)
                            .frame (width: HelpActivity.CONTENT_WIDTH-2, height: HelpActivity.IMAGE_HEIGHT-2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(0x693635), lineWidth: 2)
                        )
                        ImageView(image: self.getImage())
                            .frame (width: HelpActivity.CONTENT_WIDTH, height: HelpActivity.IMAGE_HEIGHT)
                    }
                    .gesture(DragGesture(minimumDistance: 0)
                    .onEnded { value in
                        if value.startLocation.x < value.location.x - 24 {
                            self.onLeftPage()
                        } else if value.startLocation.x > value.location.x + 24 {
                            self.onRightPage()
                        } else {
                            self.onActionSelect(x: value.location.x, y: value.location.y)
                        }
                    })
                    
                    TextView(text: self.getDetail(), top: HelpActivity.DETAIL_SPACING, horizontal: .leading, vertical: .top, fontSize: HelpActivity.FONT_SIZE, fixedSize: false)
                        .frame (width: HelpActivity.CONTENT_WIDTH, height: HelpActivity.DETAIL_HEIGHT)
                }
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
    
    enum Page: CaseIterable {
        case MOVE, PUSH, UNDO, MENU, TITLE, REVIEW, ABOUT
    }
    
    func onLeftPage() {
        let pageNumber = Page.allCases.count
        self.pageIndex = (self.pageIndex - 1 + pageNumber) % pageNumber
    }
    
    func onRightPage() {
        let pageNumber = Page.allCases.count
        self.pageIndex = (self.pageIndex + 1 + pageNumber) % pageNumber
    }
    
    func getTitle() -> String {
        let page = Page.allCases[pageIndex]
        switch (page) {
        case Page.MOVE:
            return "help_header_move".localized
        case Page.PUSH:
            return "help_header_push".localized
        case Page.UNDO:
            return "help_header_undo".localized
        case Page.MENU:
            return "help_header_menu".localized
        case Page.TITLE:
            return "help_header_title".localized
        case Page.REVIEW:
            return "help_header_review".localized
        case Page.ABOUT:
            return "help_header_about".localized
        }
    }
    func getImage() -> String {
        let page = Page.allCases[pageIndex]
        switch (page) {
        case Page.MOVE:
            return "help_move"
        case Page.PUSH:
            return "help_push"
        case Page.UNDO:
            return "help_undo"
        case Page.MENU:
            return "help_menu"
        case Page.TITLE:
            return "help_title"
        case Page.REVIEW:
            return "help_review"
        case Page.ABOUT:
            return "help_about"
        }
    }
    func getDetail() -> String {
        let page = Page.allCases[pageIndex]
        switch (page) {
        case Page.MOVE:
            return "help_detail_move".localized
        case Page.PUSH:
            return "help_detail_push".localized
        case Page.UNDO:
            return "help_detail_undo".localized
        case Page.MENU:
            return "help_detail_menu".localized
        case Page.TITLE:
            return "help_detail_title".localized
        case Page.REVIEW:
            return "help_detail_review".localized
        case Page.ABOUT:
            return "help_detail_about".localized
        }
    }
    
    func onActionSelect(x: CGFloat, y: CGFloat) {
        if Page.allCases[pageIndex] == Page.ABOUT {
            let width = HelpActivity.CONTENT_WIDTH
            let height = HelpActivity.IMAGE_HEIGHT
            let offsetX = CGFloat(15)
            let offsetY = height / 4 - 5
            if (y > offsetY && y < height - offsetY) {
                if (x > offsetX + width * 0 / 3 && x < width * 1 / 3 - offsetX) {
                    self.onGameShare()
                } else if (x > offsetX + width * 1 / 3 && x < width * 2 / 3 - offsetX) {
                    self.onGameRate()
                } else if (x > offsetX + width * 2 / 3 && x < width * 3 / 3 - offsetX) {
                    self.onGameOther()
                }
            }
        }
    }
    
    func onGameShare() {
        #if !os(watchOS)
        if let url = URL(string: "https://apps.apple.com/app/id1546106967") {
            let av = UIActivityViewController(activityItems: ["Sokoban Boxman", url], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        }
        #endif
    }
    
    func onGameRate() {
        #if !os(watchOS)
        if let url = URL(string: "itms-apps://apps.apple.com/app/id1547144066?action=write-review") {
            UIApplication.shared.open(url)
        }
        //SKStoreReviewController.requestReview();
        #endif
    }
    
    func onGameOther() {
        #if !os(watchOS)
        if let url = URL(string: "itms-apps://apps.apple.com/developer/id1546106969") {
            UIApplication.shared.open(url)
        }
        #endif
    }
    
    func onCloseButton() {
        self.content.startActivity(activity: "main")
    }
}

struct HelpActivity_Previews: PreviewProvider {
    static var previews: some View {
        HelpActivity(content : ContentView())
            .background(Color.secondary)
    }
}

