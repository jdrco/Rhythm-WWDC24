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
    private var trackViewModel: TrackViewModel? 
    private var startTime: Date? 
    
    var soundName: String {
        AudioConfig.mapPadIDToDrumFile(padID)
    }
    
    private var playerQueue: [AVAudioPlayer] = []
    
    init(padID: Int, trackViewModel: TrackViewModel? = nil) {
        self.padID = padID
        self.trackViewModel = trackViewModel
    }
    
    func playSound() {
//        guard let player = soundModel.createPlayer(with: soundName) else { return }
//        playerQueue.append(player)
//        player.delegate = self
//        player.play()
        AudioPlaybackService.shared.playSound(named: AudioConfig.mapPadIDToDrumFile(padID))
        
        if let trackVM = trackViewModel, trackVM.isRecording {
            trackVM.addBeat(padID: self.padID)
        }
    }
}



