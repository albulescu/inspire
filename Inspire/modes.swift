//
//  modes.swift
//  InspireIcon
//
//  Created by Cosmin Albulescu on 20.01.2025.
//

import Cocoa

struct Mode {
    var bIn: TimeInterval
    var wait: TimeInterval
    var bOut: TimeInterval
    init(_ int: TimeInterval, _ wait: TimeInterval, _ out: TimeInterval) {
        self.bIn = int
        self.wait = wait
        self.bOut = out
    }
}

enum Modes {

    case short
    case normal
    case deep

    func get() -> Mode {
        switch self {
        case .short:
            return Mode(1.2, 0.6, 1.2)
        case .normal:
            return Mode(1.7, 0.7, 1.7)
        case .deep:
            return Mode(4, 7, 8)
        }
    }
    
    static func fromString(s: String) -> Modes {
        switch s {
        case "short":
            return Modes.short
        case "normal":
            return Modes.normal
        case "deep":
            return Modes.deep
        default:
            return Modes.normal
        }
    }
}
