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
    @Published var isActivated = true
    @Published var tempo: Int = 100
    private var timer: Timer?
    private var currentBeat = 1
    
    private func playMetronomeSound() {
        if isActivated {
            if currentBeat == 1 {
                AudioPlaybackService.shared.playSound(named: "metronome")
            } else {
                AudioPlaybackService.shared.playSound(named: "metronomeLow")
            }
        }
        // Increment and wrap the current beat counter
        currentBeat = (currentBeat % 4) + 1
    }
    
    func startMetronome() {
        resetMetronome()
        
        // Play the first sound immediately to avoid initial delay
        playMetronomeSound()
        
        // Schedule the timer to repeat at the specified interval
        let interval = 60.0 / Double(tempo)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.playMetronomeSound()
        }
    }
    
    func stopMetronome() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetMetronome() {
        stopMetronome()
        currentBeat = 1
    }
}
