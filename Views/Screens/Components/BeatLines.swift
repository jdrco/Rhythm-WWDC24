//
//  BeatLines.swift
//  
//
//  Created by Jared Drueco on 2024-02-24.
//

import SwiftUI

struct BeatLines: View {
    @ObservedObject var trackViewModel: TrackViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<trackViewModel.numberOfBars * trackViewModel.beatsPerBar, id: \.self) { beatIndex in
                VStack {
                    if ((trackViewModel.visualCurrentBeat == 0 && beatIndex == trackViewModel.numberOfBars * trackViewModel.beatsPerBar - 1) ||
                        beatIndex == trackViewModel.visualCurrentBeat - 1) && (trackViewModel.isPlaying || trackViewModel.isRecording) {
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(width: 3)
                    } else {
                        Rectangle()
                            .fill(Color.yellow.opacity(0.5))
                            .frame(width: 2)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.white, width: 1)
    }
}
