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
}

class TrackModel {
    var beats: [Beat] = []
    var tempo: Int // BPM (beats per minute)
    var numberOfBars: Int
    
    init(tempo: Int, numberOfBars: Int) {
        self.tempo = tempo
        self.numberOfBars = numberOfBars
    }
    
    func addBeat(padID: Int, startTime: TimeInterval) {
        let beat = Beat(padID: padID, startTime: startTime)
        beats.append(beat)
    }
    
    // Calculate and return the total duration of the track based on the number of bars and tempo
    var totalDuration: TimeInterval {
        // Since there are 4 beats in a bar for 4/4 measure, and 60 seconds in a minute,
        // total duration = (60 / tempo) * 4 * numberOfBars
        return (60.0 / Double(tempo)) * 4.0 * Double(numberOfBars)
    }
}

extension TrackModel: CustomStringConvertible {
    var description: String {
        var description = "Track Model:\n"
        description += "Total Duration: \(totalDuration) seconds\n"
        description += "Beats:\n"
        
        for (index, beat) in beats.enumerated() {
            description += "Beat \(index + 1):\n"
            description += "Pad ID: \(beat.padID)\n"
            description += "Start Time: \(beat.startTime) seconds\n"
        }
        
        return description
    }
}
