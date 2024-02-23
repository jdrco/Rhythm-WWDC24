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
}

extension AudioPlaybackService {
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
                
                let filename = mapPadIDToFilename(beat.padID)
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
        let tmp = audioEngine.mainMixerNode
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
    
    private func mapPadIDToFilename(_ padID: Int) -> String {
        // Implement mapping from padID to filename
        switch padID {
        case 0:
            return "clap"
        case 1:
            return "crash"
        case 2:
            return "hihat"
        case 3:
            return "kick"
        case 4:
            return "rattle"
        case 5:
            return "snap"
        case 6:
            return "snare"
        default:
            return "tom"
        }
    }
}

