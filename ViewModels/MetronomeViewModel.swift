//
//  MetronomeViewModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI
import AVFoundation

class MetronomeViewModel: ObservableObject {
    @Published var isPlaying = false
    @Published var tempo: Int = 100
    private var timer: Timer?
    
    func toggleMetronome() {
        isPlaying.toggle()
        if isPlaying {
            startMetronome()
        } else {
            stopMetronome()
        }
    }
    
    private func startMetronome() {
        stopMetronome()
        let interval = 60.0 / Double(tempo)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            AudioPlaybackService.shared.playSound(named: "metronome")
        }
    }
    
    private func stopMetronome() {
        timer?.invalidate()
        timer = nil
    }
}
