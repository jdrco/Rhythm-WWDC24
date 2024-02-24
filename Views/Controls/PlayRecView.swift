//
//  PlayRecView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import SwiftUI

struct PlayRecView: View {
    @ObservedObject var trackViewModel: TrackViewModel
    @ObservedObject var metronomeViewModel: MetronomeViewModel
    
    var body: some View {
        HStack {
            // Record Button
            Button(action: {
                trackViewModel.toggleRecording()
                if trackViewModel.isRecording {
                    metronomeViewModel.resetMetronome()
                    metronomeViewModel.startMetronome()
                } else {
                    metronomeViewModel.resetMetronome()
                }
            }) {
                Image(systemName: trackViewModel.isRecording ? "stop.circle" : "record.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .foregroundColor(trackViewModel.isRecording ? .red : .black)
                    .background(trackViewModel.isRecording ? Color.black : Color.clear)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    )
            }
            
            // Play/Stop Button
            Button(action: {
                if trackViewModel.isPlaying {
                    trackViewModel.stopPlayback()
                    metronomeViewModel.stopMetronome()
                } else {
                    trackViewModel.startPlayback()
                    metronomeViewModel.startMetronome()
                }
            }) {
                Image(systemName: "play.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .foregroundColor(trackViewModel.isPlaying ? .white : .black)
                    .background(trackViewModel.isPlaying ? Color.black : Color.clear)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    )
            }
            .disabled(trackViewModel.isRecording)
            
            // Clear Button
            Button(action: {
                trackViewModel.clearTrack()
                metronomeViewModel.stopMetronome()
            }) {
                Image(systemName: "trash.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    )
            }
        }
        .frame(height: 50)
        .padding()
    }
}
