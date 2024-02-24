//
//  AudioEngineService.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import AVFoundation

class AudioEngineService {
    static let shared = AudioEngineService()
    let audioEngine = AVAudioEngine()
    
    init() {
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func startEngine() {
        guard !audioEngine.isRunning else { return }
        do {
            try audioEngine.start()
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    
    func stopEngine() {
        audioEngine.stop()
    }
    
    func resetEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
}
