//
//  Counter.swift
//  Fazpass Example
//
//  Created by Akbar Putera on 14/02/23.
//

import Foundation

class Counter: NSObject {
    private var timer: Timer?
    private var totalTime = 59

    var onUpdate: ((String) -> Void)?
    
    func star() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stop() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }

    @objc func updateTimer() {
        print(self.totalTime)
        onUpdate?("\(self.totalTime)")
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            stop()
        }
    }
}
