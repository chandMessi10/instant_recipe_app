//
//  IRAOTPViewModel.swift
//  InstantRecipeApp
//
//  Created by Suraj Chand on 26/02/2024.
//

import Foundation

class IRAOTPViewModel : ObservableObject {
    @Published var timerExpired = false
    @Published var timeStr = ""
    @Published var timeRemaining = 60
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        timeRemaining = 60
        timerExpired = false
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func countDownString() {
        guard (timeRemaining > 0) else {
            self.timer.upstream.connect().cancel()
            timerExpired = true
            timeStr = String(format: "%02d:%02d", 00,  00)
            return
        }
        
        timeRemaining -= 1
        timeStr = String(format: "%02d:%02d", 00, timeRemaining)
    }
}
