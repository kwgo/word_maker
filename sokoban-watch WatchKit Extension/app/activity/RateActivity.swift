//
//  RateActivity.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-02.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import SwiftUI
import StoreKit

struct RateActivity: View {
    var content: GameView

    var body: some View {
        DimeView {
            VStack {
                LabelView(label: "review_title".localized).padding()
                ButtonView(title: "review_yes".localized, color: .detailColor) {
                    self.onRateButton()
                }
                ButtonView(title: "review_no".localized) {
                    self.onReturnButton()
                }
            }
        }
    }
    private func onRateButton() {
        self.content.showRateFlag = false
        #if !os(watchOS)
            SKStoreReviewController.requestReview();
        #endif
    }
    private func onReturnButton() {
        self.content.showRateFlag = false
    }
}

struct RateActivity_Previews: PreviewProvider {
    static var previews: some View {
        RateActivity(content: GameView(content: GameActivity(content: ContentView())))
    }
}

