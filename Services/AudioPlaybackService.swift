//
//  AudioPlaybackService.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-23.
//

import AVFoundation

class AudioPlaybackService: ObservableObject {
    static let shared = AudioPlaybackService()
    private var playerPool = [AVAudioPlayerNode]()
    private let audioEngineService = AudioEngineService.shared
    private var isLooping = false
    private var loopTimer: Timer?
    private var activePlayers = [AVAudioPlayerNode]()
    
    init() {
        // Pre-initialize a pool of player nodes to avoid creating them on the fly.
        preparePlayerPool()
    }
    
    private func preparePlayerPool(size: Int = 10) {
        for _ in 0..<size {
            let player = AVAudioPlayerNode()
            audioEngineService.audioEngine.attach(player)
            playerPool.append(player)
        }
    }
    
    private func getPlayerFromPool() -> AVAudioPlayerNode? {
        if playerPool.isEmpty {
            let player = AVAudioPlayerNode()
            audioEngineService.audioEngine.attach(player)
            return player
        } else {
            return playerPool.removeFirst()
        }
    }
    
    private func loadAudioFile(named filename: String) -> AVAudioFile? {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "wav") else {
            print("Could not load file: \(filename)")
            return nil
        }
        return try? AVAudioFile(forReading: fileURL)
    }
    
    func playSound(named soundName: String, at time: AVAudioTime? = nil) {
        guard let audioFile = loadAudioFile(named: soundName) else { return }
        
        if let player = getPlayerFromPool() {
            audioEngineService.audioEngine.attach(player)
            audioEngineService.audioEngine.connect(player, to: audioEngineService.audioEngine.mainMixerNode, format: audioFile.processingFormat)
            player.scheduleFile(audioFile, at: time, completionHandler: {
                // Return the player to the pool after playing
                DispatchQueue.main.async { [weak self] in
                    self?.returnPlayerToPool(player: player)
                }
            })
            
            if !audioEngineService.audioEngine.isRunning {
                audioEngineService.startEngine()
            }
            
            player.play()
            activePlayers.append(player)
        }
    }
    
    private func returnPlayerToPool(player: AVAudioPlayerNode) {
        if let index = activePlayers.firstIndex(of: player) {
            activePlayers.remove(at: index)
            playerPool.append(player)
        }
    }
    
    func playTrack(_ track: TrackModel) {
        if track.beats.isEmpty {
            print("No track to be played")
            return
        }
        
        // No need to reset engine if it's already running
        if !audioEngineService.audioEngine.isRunning {
            audioEngineService.startEngine()
        }
        
        for beat in track.beats {
            let filename = AudioConfig.mapPadIDToDrumFile(beat.padID)
            guard let audioFile = loadAudioFile(named: filename) else {
                print("Could not load audio file: \(filename)")
                continue
            }
            
            if let player = getPlayerFromPool() {
                setupPlaybackFor(player: player, with: audioFile, atBeat: beat)
                activePlayers.append(player)
            }
        }
        
        // Start playback without restarting the engine
        activePlayers.forEach { $0.play() }
        
        // Cleanup if not looping
        if !isLooping {
            DispatchQueue.main.asyncAfter(deadline: .now() + track.totalDuration) {
                self.stopPlayback()
            }
        }
    }
    
    func loopTrack(_ track: TrackModel) {
        stopPlayback() // Stop any current playback
        isLooping = true
        
        let trackDuration = track.totalDuration
        playTrack(track)
        
        loopTimer?.invalidate()
        loopTimer = Timer.scheduledTimer(withTimeInterval: trackDuration, repeats: true) { [weak self] _ in
            guard let self = self, self.isLooping else { return }
            self.playTrack(track) // Re-play the track at the end of each loop
        }
    }
    
    func stopPlayback() {
        isLooping = false
        loopTimer?.invalidate()
        loopTimer = nil
        
        activePlayers.forEach { player in
            player.stop()
            // Return player to pool instead of detaching
            if let index = self.activePlayers.firstIndex(of: player) {
                self.activePlayers.remove(at: index)
                self.playerPool.append(player)
            }
        }
    }
    
    private func setupPlaybackFor(player: AVAudioPlayerNode, with audioFile: AVAudioFile, atBeat beat: Beat) {
        let sampleRate = audioFile.processingFormat.sampleRate
        let sampleTime = AVAudioFramePosition(Double(beat.startTime) * sampleRate)
        let time = AVAudioTime(sampleTime: sampleTime, atRate: sampleRate)
        
        audioEngineService.audioEngine.connect(player, to: audioEngineService.audioEngine.mainMixerNode, format: audioFile.processingFormat)
        player.scheduleFile(audioFile, at: time, completionHandler: nil)
    }
}
