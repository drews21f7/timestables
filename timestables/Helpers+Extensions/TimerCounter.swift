//
//  TimerCounter.swift
//  timestables
//
//  Created by Drew Seeholzer on 12/2/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation

protocol TimerCounterDelegate: class {
    //func timerStopped()
    func timerCompleted()
    func timerSecondTicked()
}

class TimerCounter: NSObject {

    var timeRemaining: TimeInterval?

    var timer: Timer?

    weak var delegate: TimerCounterDelegate?

    var isOn: Bool {
        if timeRemaining != nil {
            return true
        } else {
            return false
        }
    }

    private func secondTicked() {
        guard let timeRemaining = timeRemaining else { return }
        if timeRemaining > 0 {
            self.timeRemaining = timeRemaining - 1
            delegate?.timerSecondTicked()
            print(timeRemaining)
        } else {
            timer?.invalidate()
            self.timeRemaining = nil
            delegate?.timerCompleted()
        }
    }
    
    func startTimer(_ time: TimeInterval) {
        if isOn == false {
            self.timeRemaining = time
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                self.secondTicked()
            })
        }
    }
    
    func stopTimer() {
        if isOn {
            self.timeRemaining = nil
            timer?.invalidate()
            //delegate?.timerStopped()
        }
    }
}
