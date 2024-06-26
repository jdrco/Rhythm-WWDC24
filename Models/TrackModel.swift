//
//  TrackModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI

class TrackModel {
    var beats: [BeatModel] = []
    var tempo: Int // In beats per minute
    var numberOfBars: Int
    var beatsPerBar: Int
    
    init(tempo: Int, numberOfBars: Int, beatsPerBar: Int, beats: [BeatModel] = []) {
        self.tempo = tempo
        self.numberOfBars = numberOfBars
        self.beatsPerBar = beatsPerBar
        self.beats = beats
    }
    
    func addBeat(padID: Int, startTime: TimeInterval, barNumber: Int) {
        let beat = BeatModel(padID: padID, startTime: startTime, barNumber: barNumber)
        beats.append(beat)
    }
    
    var totalDuration: TimeInterval {
        // Since there are 4 beats in a bar for 4/4 measure, and 60 seconds in a minute,
        return (60.0 / Double(tempo)) * Double(beatsPerBar) * Double(numberOfBars)
    }
}

extension TrackModel: CustomStringConvertible {
    // Helpful for debugging
    var description: String {
        var description = "Track Model:\n"
        description += "Total Duration: \(totalDuration) seconds\n"
        description += "Beats: "
        
        if !beats.isEmpty {
            description += beats.map { beat in
                return "(Pad ID: \(beat.padID), Start Time: \(beat.startTime) seconds), Bar: \(beat.barNumber)"
            }.joined(separator: ", ")
        } else {
            description += "No beats"
        }
        
        return description
    }
}
