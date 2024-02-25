//
//  PlayScreenView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-20.
//

import SwiftUI

struct BarGrid: View {
    let numberOfBars: Int
    let currentBeat: Int
    let visualCurrentBeat: Int
    let isPlaying: Bool
    let isRecording: Bool
    let beatsPerBar: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<numberOfBars * beatsPerBar, id: \.self) { beatIndex in
                VStack {
                    if ((visualCurrentBeat == 0 && beatIndex == numberOfBars * beatsPerBar - 1) ||
                        beatIndex == visualCurrentBeat - 1) && (isPlaying || isRecording) {
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(width: 3)
                    } else {
                        Rectangle()
                            .fill(Color.yellow.opacity(0.5))
                            .frame(width: 2)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(Color.black, width: 1)
    }
}

struct BeatGrid: View {
    let numberOfBeats: Int = AudioConfig.drumFiles.count
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<numberOfBeats, id: \.self) { _ in
                Divider()
                    .background(Color.black)
                Spacer()
            }
        }
    }
}



struct PlayScreenView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @EnvironmentObject var audioPlaybackService: AudioPlaybackService
    @ObservedObject var trackViewModel: TrackViewModel
    
    var body: some View {
        ZStack {
            Color.gray
                .frame(maxHeight: .infinity)
                .cornerRadius(10)
            BarGrid(numberOfBars: trackViewModel.numberOfBars, currentBeat: trackViewModel.currentBeat, visualCurrentBeat: trackViewModel.visualCurrentBeat, isPlaying: trackViewModel.isPlaying, isRecording: trackViewModel.isRecording, beatsPerBar: trackViewModel.beatsPerBar)
            BeatGrid()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1.5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.4), lineWidth: 8)
                        .blur(radius: 6)
                        .offset(x: 0, y: 0)
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
}
