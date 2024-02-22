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
    private var soundModel: SoundModel
    
    var soundName: String {
        soundModel.soundName
    }
    
    private var playerQueue: [AVAudioPlayer] = []
    
    init(soundModel: SoundModel) {
        self.soundModel = soundModel
    }
    
    func playSound() {
        guard let player = soundModel.createPlayer(with: soundName) else { return }
        playerQueue.append(player)
        player.delegate = self
        player.play()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            // Clean up the player from the queue when it finishes playing.
            self.playerQueue.removeAll { $0 == player }
        }
    }
}



