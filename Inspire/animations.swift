//
//  animations.swift
//  InspireIcon
//
//  Created by Cosmin Albulescu on 20.01.2025.
//

import Cocoa

class Animation {
    private var currentIndex: Int = 0
    private var timer: Timer?
    
    func run(from start: Int, to end: Int, duration: TimeInterval, easing: Ease, update: @escaping (Int) -> Void, completion: (() -> Void)? = nil) {
        currentIndex = start
        let totalSteps = Int(duration * 60)
        var currentStep = 0
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { [self] timer in
            
            if currentStep > totalSteps {
                timer.invalidate()
                self.timer = nil
                completion?()
                return
            }
            
            let t = Double(currentStep) / Double(totalSteps) // Normalized time (0.0 to 1.0)
            let easedT = easing.value(at: t) // Apply easing function
            let newIndex = Int(Double(start) + (Double(end - start) * easedT))
            
            if newIndex != self.currentIndex {
                self.currentIndex = newIndex
                update(self.currentIndex)
            }
            
            currentStep += 1
        }
        timer?.fire()
    }
}

enum Ease {

    case linear
    case easeIn
    case easeOut
    case easeInOut

    func value(at t: Double) -> Double {
        switch self {
        case .linear:
            return t
        case .easeIn:
            return pow(t, 3) // Cubic ease-in
        case .easeOut:
            return 1 - pow(1 - t, 3) // Cubic ease-out
        case .easeInOut:
            return t < 0.5
                ? 4 * pow(t, 3) // Ease-in for first half
                : 1 - pow(-2 * t + 2, 3) / 2 // Ease-out for second half
        }
    }
}
