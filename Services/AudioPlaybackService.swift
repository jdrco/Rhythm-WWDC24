//
//  AudioPlaybackService.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-23.
//

import AVFoundation

class AudioPlaybackService {
    static let shared = AudioPlaybackService()
    private var players = [AVAudioPlayerNode]()
    private let engineService = AudioEngineService.shared
    
    private func loadAudioFile(named filename: String) -> AVAudioFile? {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "wav") else {
            print("Could not load file: \(filename)")
            return nil
        }
        return try? AVAudioFile(forReading: fileURL)
    }
    
    func playSound(named soundName: String, at time: AVAudioTime? = nil) {
        let player = AVAudioPlayerNode()
        engineService.audioEngine.attach(player)
        guard let audioFile = loadAudioFile(named: soundName) else { return }
        
        engineService.audioEngine.connect(player, to: engineService.audioEngine.mainMixerNode, format: audioFile.processingFormat)
        player.scheduleFile(audioFile, at: time, completionHandler: nil)
        engineService.startEngine()
        player.play()
        players.append(player)
    }
    
    private func setupPlaybackFor(player: AVAudioPlayerNode, with audioFile: AVAudioFile, atBeat beat: Beat) {
        let sampleRate = audioFile.processingFormat.sampleRate
        let sampleTime = AVAudioFramePosition(Double(beat.startTime) * sampleRate)
        let time = AVAudioTime(sampleTime: sampleTime, atRate: sampleRate)
        
        engineService.audioEngine.connect(player, to: engineService.audioEngine.mainMixerNode, format: audioFile.processingFormat)
        player.scheduleFile(audioFile, at: time, completionHandler: nil)
        players.append(player)
    }
    
    func playTrack(_ track: TrackModel) {
        if track.beats.count == 0 {
            print("No track to be played")
            return
        }
        engineService.resetEngine()
        
        for beat in track.beats {
            let filename = AudioConfig.mapPadIDToDrumFile(beat.padID)
            guard let audioFile = loadAudioFile(named: filename) else {
                print("Could not load audio file: \(filename)")
                continue
            }
            
            let player = AVAudioPlayerNode()
            engineService.audioEngine.attach(player)
            setupPlaybackFor(player: player, with: audioFile, atBeat: beat)
        }
        
        engineService.startEngine()
        players.forEach { $0.play() }
    }
    
    func stopPlayback() {
        players.forEach { $0.stop() }
        players.removeAll { player in
            engineService.audioEngine.detach(player)
            return true
        }
    }
}
