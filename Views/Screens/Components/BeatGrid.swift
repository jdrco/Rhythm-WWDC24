//
//  BeatGrid.swift
//
//
//  Created by Jared Drueco on 2024-02-24.
//

import SwiftUI

struct BeatGrid: View {
    @ObservedObject var trackViewModel: TrackViewModel
    let numberOfBeats: Int = AudioConfig.drumFiles.count

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Drawing dividers and spacers for each beat row
                VStack(spacing: 0) {
                    ForEach(0..<numberOfBeats, id: \.self) { padID in
                        Divider().background(Color.black)
                        Spacer() // Creates a spacer that will be used to separate each beat row
                    }
                }
                
                // Iterate over each row (padID)
                ForEach(0..<numberOfBeats, id: \.self) { padID in
                    // Find the beats for the current row (padID)
                    let beatsForRow = trackViewModel.trackModel.beats.filter { $0.padID == padID }
                    
                    ForEach(beatsForRow, id: \.startTime) { beat in
                        let totalDuration = trackViewModel.trackModel.totalDuration
                        let beatStartFraction = beat.startTime / totalDuration
                        
                        // Calculate x position based on beat start time
                        let beatXPosition = geometry.size.width * CGFloat(beatStartFraction)
                        
                        // Calculate y position based on pad ID
                        let rowHeight = geometry.size.height / CGFloat(numberOfBeats)
                        let beatYPosition = rowHeight * CGFloat(padID) + rowHeight / 2
                        
                        Rectangle()
                            .fill(Color.blue) // Color of the rectangle
                            .frame(width: 10, height: rowHeight) // Width is placeholder, height matches row height
                            .position(x: beatXPosition, y: beatYPosition) // Positioning the rectangle in the correct row
                    }
                }
            }
        }
    }
}