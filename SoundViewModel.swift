//
//  SoundViewModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-21.
//

import Foundation
import AVFoundation

class SoundViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var soundName: String
    /* Default behavior is to restart the sound from the beginning each time
     play() is called, which can cut off the currently playing sound if it
     hasn't finished. Hold active players to prevent them from being deallocated. */
    private var playerQueue: [AVAudioPlayer] = []
    
    init(soundName: String) {
        self.soundName = soundName
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            playerQueue.append(player)
            player.delegate = self // Clean up the player when it's finished playing
        } catch {
            print("Could not load file")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playerQueue.removeAll { $0 == player }
    }
}



