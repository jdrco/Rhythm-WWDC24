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
    
    init(tempo: Int = 100, numberOfBars: Int = 1) {
        self.trackModel = TrackModel(tempo: tempo, numberOfBars: numberOfBars)
    }
    
    func toggleRecording() {
        isRecording.toggle()
        if isRecording {
            print("Start recording")
            trackModel.beats.removeAll()
            recordingStartTime = Date()
        } else {
            print("Stop recording")
            self.stopPlayback()
            recordingStartTime = nil
            // TODO: process/save the recording as needed
        }
    }
    
    // Add a beat to the trackModel directly, calculating the offset from the recording start
    func addBeat(padID: Int) {
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
        guard !isRecording, !isPlaying else { return }
        isPlaying = true
        AudioPlaybackService.shared.playTrack(trackModel)
    }
    
    func stopPlayback() {
        guard isPlaying else { return }
        AudioPlaybackService.shared.stopPlayback()
        isPlaying = false
    }
    
    func clearTrack() {
        trackModel = TrackModel(tempo: trackModel.tempo, numberOfBars: trackModel.numberOfBars)
        isRecording = false
        isPlaying = false
    }
}