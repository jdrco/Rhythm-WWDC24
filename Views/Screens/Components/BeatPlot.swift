//
//  BeatPlot.swift
//
//
//  Created by Jared Drueco on 2024-02-24.
//

import SwiftUI

struct BeatPlot: View {
    @ObservedObject var trackViewModel: TrackViewModel
    let numberOfBeats: Int = AudioConfig.drumFiles.count
    
    var body: some View {
        GeometryReader { geometry in
            // Calculate x offset and convertion
            let totalDuration = trackViewModel.trackModel.totalDuration
            let numberOfBars = trackViewModel.numberOfBars
            let barDuration = totalDuration / Double(numberOfBars)
            
            let barWidth = geometry.size.width / CGFloat(trackViewModel.numberOfBars)
            let padding: CGFloat = (geometry.size.width / CGFloat(trackViewModel.beatsPerBar * trackViewModel.numberOfBars)) / 2
            let timeToPositionConversion = geometry.size.width / trackViewModel.trackModel.totalDuration
            // Iterate over each row (padID)
            ForEach(0..<numberOfBeats, id: \.self) { padID in
                // Find the beats for the current row (padID)
                let beatsForRow = trackViewModel.trackModel.beats.filter { $0.padID == padID }
                
                ForEach(beatsForRow, id: \.startTime) { beat in
                    // Calculate x position based on beat
                    let isLastBar = beat.barNumber == trackViewModel.numberOfBars - 1
                    var adjustedStartTime: Double {
                        // Check if we need to adjust startTime based on the specific conditions
                        if beat.startTime > 3.5 && (isLastBar || trackViewModel.numberOfBars == 1) {
                            return beat.startTime - 4.0 * Double(beat.barNumber + 1)
                        } else {
                            // Default case where startTime is not adjusted
                            return beat.startTime
                        }
                    }
                    let beatTimetoXPosition = adjustedStartTime * CGFloat(timeToPositionConversion)
                    let beatXPositionAfterOffset = beatTimetoXPosition + (CGFloat(beat.barNumber) * (barWidth)) + padding
                    
                    // Calculate y position based on pad ID
                    let rowHeight = geometry.size.height / CGFloat(numberOfBeats)
                    let beatYPosition = rowHeight * CGFloat(padID) + rowHeight / 2
                    
                    Rectangle()
                        .fill(Color.cyan)
                        .frame(width: 10, height: rowHeight) // Width is placeholder for now as there is no hold duration logic yet.
                        .position(x: beatXPositionAfterOffset, y: beatYPosition)
                }
            }
        }
    }
}
