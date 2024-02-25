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
    @Published var numberOfBars: Int {
        didSet {
            trackModel.numberOfBars = numberOfBars
        }
    }
    @Published var beatsPerBar: Int
    private var timer: Timer?
    @Published var currentBeat = 0
    @Published var visualCurrentBeat = 0
    private var totalBeatsPlayed = 0
    
    private var audioPlaybackService = AudioPlaybackService.shared
    
    init(tempo: Int = 60, numberOfBars: Int = 1, beatsPerBar: Int = 4) {
        self.tempo = tempo
        self.numberOfBars = numberOfBars
        self.beatsPerBar = beatsPerBar
        self.trackModel = TrackModel(tempo: tempo, numberOfBars: numberOfBars, beatsPerBar: beatsPerBar)
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
        let barDuration = 60.0 / Double(trackModel.tempo) * Double(beatsPerBar)
        
        // Calculate which bar the beat falls into
        let barNumber = Int(beatTime / barDuration) % trackModel.numberOfBars
        
        // Apply circular buffer logic (loop time)
        beatTime = beatTime.truncatingRemainder(dividingBy: barDuration)
        
        print("Adjusted Hit on: \(beatTime), ID: \(padID)")
        
        self.objectWillChange.send()
        trackModel.addBeat(padID: padID, startTime: beatTime, barNumber: barNumber)
        print(trackModel.description)
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
        trackModel = TrackModel(tempo: trackModel.tempo, numberOfBars: trackModel.numberOfBars, beatsPerBar: trackModel.beatsPerBar)
        isRecording = false
        isPlaying = false
        recordingStartTime = nil
    }
    
    private func playMetronomeSound() {
        if metronomeActivated {
            if currentBeat == 0 {
                audioPlaybackService.playSound(named: "metronome")
            } else {
                audioPlaybackService.playSound(named: "metronomeLow")
            }
        }
        // Increment and wrap the current beat counter
        currentBeat = (currentBeat + 1) % 4
        totalBeatsPlayed += 1
        visualCurrentBeat = totalBeatsPlayed % (4 * numberOfBars)
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
        currentBeat = 0
        totalBeatsPlayed = 0
        visualCurrentBeat = 0
    }
}
