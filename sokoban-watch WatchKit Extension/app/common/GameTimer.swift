//
//  GameTimer.swift
//  boxman
//
//  Created by Jiang Chang on 2020-07-09.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import Foundation

public class GameTimer {
    private var timer: Timer? = nil
    private var finishWork: DispatchWorkItem? = nil
    private var intervalWork: DispatchWorkItem? = nil
    private var counter = 0
    
    init (interval:Double, execute intervalWork: DispatchWorkItem?, counter: Int = 1, execute finishWork: DispatchWorkItem? = nil) {
        self.finishWork = finishWork
        self.intervalWork = intervalWork
        
        self.counter = counter
        self.timer = Timer.scheduledTimer(timeInterval: interval, target: self,
                                          selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc private func countdown(timer:Timer) {
        if(self.counter > 0) {
            intervalWork?.perform()
            counter -= 1
        } else if (counter == 0) {
            finishWork?.perform()
            self.timer = nil
        }
    }
    
    public func invalidate() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
