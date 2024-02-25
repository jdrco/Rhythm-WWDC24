//
//  TrackModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI

struct Beat {
    let padID: Int
    let startTime: TimeInterval
    let barNumber: Int
}

class TrackModel {
    var beats: [Beat] = []
    var tempo: Int // BPM (beats per minute)
    var numberOfBars: Int
    var beatsPerBar: Int
    
    init(tempo: Int, numberOfBars: Int, beatsPerBar: Int) {
        self.tempo = tempo
        self.numberOfBars = numberOfBars
        self.beatsPerBar = beatsPerBar
    }
    
    func addBeat(padID: Int, startTime: TimeInterval, barNumber: Int) {
        let beat = Beat(padID: padID, startTime: startTime, barNumber: barNumber)
        beats.append(beat)
    }
    
    // Calculate and return the total duration of the track based on the number of bars and tempo
    var totalDuration: TimeInterval {
        // Since there are 4 beats in a bar for 4/4 measure, and 60 seconds in a minute,
        return (60.0 / Double(tempo)) * Double(beatsPerBar) * Double(numberOfBars)
    }
}

extension TrackModel: CustomStringConvertible {
    var description: String {
        var description = "Track Model:\n"
        description += "Total Duration: \(totalDuration) seconds\n"
        description += "Beats: "
        
        // Check if there are beats in the array
        if !beats.isEmpty {
            // Iterate through beats and concatenate the information
            description += beats.map { beat in
                return "(Pad ID: \(beat.padID), Start Time: \(beat.startTime) seconds), Bar: \(beat.barNumber)"
            }.joined(separator: ", ")
        } else {
            description += "No beats"
        }
        
        return description
    }
}
