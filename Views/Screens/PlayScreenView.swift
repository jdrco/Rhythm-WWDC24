//
//  PlayScreenView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-20.
//

import SwiftUI

struct PlayScreenView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @EnvironmentObject var audioPlaybackService: AudioPlaybackService
    @ObservedObject var trackViewModel: TrackViewModel
    let numberOfBeats: Int = AudioConfig.drumFiles.count
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.gray
                    .frame(maxHeight: .infinity)
                    .cornerRadius(10)
                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(0..<numberOfBeats, id: \.self) { padID in
                            Spacer()
                            Text("\(AudioConfig.mapPadIDToDrumFile(padID).uppercased())")
                                .font(.system(size: 12, weight: .regular))
                            Spacer()
                        }
                    }
                    ZStack {
                        BarGrid(trackViewModel: trackViewModel)
                        BeatGrid(trackViewModel: trackViewModel)
                    }
                }
                .padding(20)
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
    
}
