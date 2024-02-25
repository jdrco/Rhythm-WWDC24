//
//  BeatTracker.swift
//
//
//  Created by Jared Drueco on 2024-02-25.
//

import SwiftUI

struct BeatTracker: View {
    @ObservedObject var trackViewModel: TrackViewModel
    let numberOfBeats: Int = AudioConfig.drumFiles.count

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    ForEach(0..<numberOfBeats, id: \.self) { padID in
                        Divider().background(Color.white)
                        Spacer()
                    }
                }
                BeatLines(trackViewModel: trackViewModel)
                BeatPlot(trackViewModel: trackViewModel)
            }
        }
    }
}

