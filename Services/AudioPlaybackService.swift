//
//  AudioPlaybackService.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import AVFoundation

class AudioPlaybackService {
    static let shared = AudioPlaybackService()
    private var audioEngine = AVAudioEngine()
    private var players = [AVAudioPlayerNode]()
    private var audioFiles = [AVAudioFile]()
    
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
    
    // Enhanced method to play a sound immediately or schedule it.
    func playSound(named soundName: String, at time: AVAudioTime? = nil) {
        let player = AVAudioPlayerNode()
        audioEngine.attach(player)

        guard let fileURL = Bundle.main.url(forResource: soundName, withExtension: "wav"),
              let audioFile = try? AVAudioFile(forReading: fileURL) else {
            print("Could not load file: \(soundName)")
            return
        }

        audioEngine.connect(player, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
        if let scheduledTime = time {
            player.scheduleFile(audioFile, at: scheduledTime, completionHandler: nil)
        } else {
            player.scheduleFile(audioFile, at: nil, completionHandler: nil)
            try? audioEngine.start()
            player.play()
        }

        // Keep a reference if needed to stop later or manage playback state.
        players.append(player)
    }
    
    func playTrack(_ track: TrackModel) {
        print(track)
        stopPlayback()
        
        // Configure the audio engine
        audioEngine.reset()
        players.removeAll()
        audioFiles.removeAll()
        
        for beat in track.beats {
            do {
                let player = AVAudioPlayerNode()
                audioEngine.attach(player)
                
                let filename = AudioConfig.mapPadIDToDrumFile(beat.padID)
                guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "wav") else { continue }
                let audioFile = try AVAudioFile(forReading: fileURL)
                
                audioEngine.connect(player, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
                
                players.append(player)
                audioFiles.append(audioFile)
                
                // Calculate the time to play each beat
                let sampleRate = audioFile.processingFormat.sampleRate
                let sampleTime = AVAudioFramePosition(Double(beat.startTime) * sampleRate)
                let time = AVAudioTime(sampleTime: sampleTime, atRate: sampleRate)
                
                // Schedule file playback
                player.scheduleFile(audioFile, at: time, completionHandler: nil)
            } catch {
                print("Error scheduling audio file: \(error)")
            }
        }
        
        // Start the audio engine
        let _ = audioEngine.mainMixerNode
        do {
            try audioEngine.start()
            // Start playback for all players
            players.forEach { $0.play() }
        } catch {
            print("Error starting audio engine: \(error)")
        }
    }
    
    func stopPlayback() {
        players.forEach { $0.stop() }
        audioEngine.stop()
    }
}

