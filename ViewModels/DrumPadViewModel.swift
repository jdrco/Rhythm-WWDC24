//
//  DrumPadViewModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-21.
//

import Foundation
import AVFoundation

class DrumPadViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    /* Default behavior is to restart the sound from the beginning each time
     play() is called, which can cut off the currently playing sound if it
     hasn't finished. Hold active players to prevent them from being deallocated. */
    private var padID: Int
    private var soundModel: SoundModel
    private var trackViewModel: TrackViewModel? 
    private var startTime: Date? 
    
    var soundName: String {
        soundModel.soundName
    }
    
    private var playerQueue: [AVAudioPlayer] = []
    
    init(padID: Int, soundModel: SoundModel, trackViewModel: TrackViewModel? = nil) {
        self.padID = padID
        self.soundModel = soundModel
        self.trackViewModel = trackViewModel
    }
    
    func playSound() {
        guard let player = soundModel.createPlayer(with: soundName) else { return }
        playerQueue.append(player)
        player.delegate = self
        player.play()
        
        if let trackVM = trackViewModel, trackVM.isRecording {
            trackVM.addBeat(padID: self.padID)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            if let trackVM = self.trackViewModel, trackVM.isRecording, let startTime = self.startTime {
                // Calculate the beat's timing relative to the recording start
                let beatTime = Date().timeIntervalSince(startTime)
                trackVM.trackModel.addBeat(padID: self.padID, startTime: beatTime)
            }
            
            self.playerQueue.removeAll { $0 == player }
        }
    }
}



