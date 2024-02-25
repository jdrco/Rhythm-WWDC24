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
    
    var body: some View {
        ZStack {
            Color.gray
                .frame(maxHeight: .infinity)
                .cornerRadius(10)
            BarGrid(trackViewModel: trackViewModel)
                .padding(20)
            BeatGrid(trackViewModel: trackViewModel)
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
