//
//  SoundModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-21.
//

import Foundation
import AVFoundation

struct SoundModel {
    var soundName: String
    private var player: AVAudioPlayer?

    init(soundName: String) {
        self.soundName = soundName
    }

    mutating func playSound() {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Could not load file")
        }
    }
}
