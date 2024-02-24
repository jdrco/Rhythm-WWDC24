//
//  TrackViewModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI

class TrackViewModel: ObservableObject {
    @Published var trackModel: TrackModel
    @Published var isRecording: Bool = false
    @Published var isPlaying: Bool = false
    var recordingStartTime: Date?
    
    @Published var metronomeActivated = true
    @Published var tempo: Int {
        didSet {
            trackModel.tempo = tempo
        }
    }
    @Published var numberOfBars: Int
    private var timer: Timer?
    private var currentBeat = 1
    
    private var audioPlaybackService = AudioPlaybackService.shared
    
    init(tempo: Int, numberOfBars: Int) {
        self.tempo = tempo
        self.numberOfBars = numberOfBars
        self.trackModel = TrackModel(tempo: tempo, numberOfBars: numberOfBars)
    }
    
    func toggleRecording() {
        isRecording.toggle()
        if isRecording {
            print("Start recording")
            trackModel.beats.removeAll()
            recordingStartTime = Date()
            startPlayback()
        } else {
            print("Stop recording")
            stopPlayback()
            recordingStartTime = nil
            // TODO: process/save the recording as needed
        }
    }
    
    func trackPlayedSound(padID: Int) {
        audioPlaybackService.playSound(named: AudioConfig.mapPadIDToDrumFile(padID))
        guard let start = recordingStartTime else { return }
        let currentTime = Date()
        var beatTime = currentTime.timeIntervalSince(start)
        
        // Calculate the duration of a single bar in seconds
        let barDuration = 60.0 / Double(trackModel.tempo) * 4.0
        
        // Apply circular buffer logic (loop time)
        beatTime = beatTime.truncatingRemainder(dividingBy: barDuration)
        
        print("Adjusted Hit on: \(beatTime), ID: \(padID)")
        
        trackModel.addBeat(padID: padID, startTime: beatTime)
    }
    
    func startPlayback() {
        isPlaying = true
        audioPlaybackService.loopTrack(trackModel)
    }
    
    func stopPlayback() {
        guard isPlaying else { return }
        audioPlaybackService.stopPlayback()
        isPlaying = false
    }
    
    func clearTrack() {
        stopPlayback()
        trackModel = TrackModel(tempo: trackModel.tempo, numberOfBars: trackModel.numberOfBars)
        isRecording = false
        isPlaying = false
        recordingStartTime = nil
    }
    
    private func playMetronomeSound() {
        if metronomeActivated {
            if currentBeat == 1 {
                audioPlaybackService.playSound(named: "metronome")
            } else {
                audioPlaybackService.playSound(named: "metronomeLow")
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
        let interval = 60.0 / Double(trackModel.tempo)
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
