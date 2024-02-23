//
//  AudioConfig.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-23.
//

struct AudioConfig {
    static let drumFiles = ["clap", "crash", "hihat", "kick", "rattle", "snap", "snare", "tom"]
    static let metronomeFile = "metronome"
    
    static func mapPadIDToDrumFile(_ padID: Int) -> String {
        return AudioConfig.drumFiles[padID]
    }
}
