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

    func createPlayer() -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {
            print("Could not load file: \(soundName)")
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            return player
        } catch {
            print("Could not initialize AVAudioPlayer: \(error)")
            return nil
        }
    }
}
