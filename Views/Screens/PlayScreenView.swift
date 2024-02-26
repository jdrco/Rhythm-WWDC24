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
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<numberOfBeats, id: \.self) { padID in
                    Spacer()
                    Text("\(AudioConfig.mapPadIDToDrumFile(padID).uppercased())")
                        .font(.system(size: 10, weight: .light, design: .monospaced))
                        .foregroundStyle(Color.white)
                    Spacer()
                }
            }
            BeatTracker(trackViewModel: trackViewModel)
        }
        .padding(20)
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
    
}
