//
//  main.swift
//  Inspire
//
//  Created by Cosmin Albulescu on 19.01.2025.
//

import ArgumentParser
import Cocoa

if #available(macOS 10.15, *) {
    NSApplication.shared.setActivationPolicy(.accessory)
}

let icon = NSStatusBar.system.statusItem(
    withLength: NSStatusItem.squareLength
)

struct Inspire: ParsableCommand {
    
    @Option(help: "Mode [short, normal, deep]. Default normal.")
    var mode = "normal"
    
    @Option(help: "Gap in seconds. Default 2.")
    var gap = 2

    func run() throws {
        start(mode: Modes.fromString(s: mode).get(), gap: gap)
        RunLoop.main.run()
    }
}

func start(mode: Mode, gap: Int = 2) {
    breath(mode: mode) {
        usleep(UInt32(gap) * 1_000_000)
        start(mode: mode, gap: gap)
    }
}

func breath(mode: Mode, done: @escaping () -> Void) {
    Animation().run(from: 0, to: 9, duration: mode.bIn, easing: .linear) { n in
        setFrameIndex(n)
    } completion: {
        usleep(UInt32(mode.wait) * 1_000_000)
        Animation().run(from: 0, to: 9, duration: mode.bOut, easing: .linear) { n in
            setFrameIndex(9-n)
        } completion: {
            setFrameIndex(-1)
            DispatchQueue.main.async {
                done()
            }
        }
    }
}

func setFrameIndex(_ index: Int) {
    
    if index == -1 {
        icon.button!.image = NSImage()
        return
    }
    
    guard index >= 0 && index < frames.count else { return }
    
    guard let imageData = Data(base64Encoded: frames[index], options: .ignoreUnknownCharacters) else {
        return
    }
    
    icon.button!.image = NSImage(data: imageData)
}

Inspire.main()
