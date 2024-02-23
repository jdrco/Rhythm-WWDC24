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
    private var soundModel: SoundModel
    
    init() {
        self.soundModel = SoundModel(soundName: "metronome")
    }
    
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
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in        
            self?.soundModel.player?.play()
        }
    }
    
    private func stopMetronome() {
        timer?.invalidate()
        timer = nil
        soundModel.player?.stop()
        soundModel.player?.currentTime = 0
    }
}
