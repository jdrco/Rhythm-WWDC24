//
//  PlaybackControlView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import SwiftUI

struct PlaybackControlView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @ObservedObject var trackViewModel: TrackViewModel
    
    var body: some View {
        HStack {
            // Record Button
            Button(action: {
                trackViewModel.toggleRecording()
                if trackViewModel.isRecording {
                    trackViewModel.resetMetronome()
                    trackViewModel.startMetronome()
                } else {
                    trackViewModel.resetMetronome()
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
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(!audioEngineService.isRunning)
            
            
            // Play/Stop Button
            Button(action: {
                if trackViewModel.isPlaying {
                    trackViewModel.stopPlayback()
                    trackViewModel.stopMetronome()
                } else {
                    trackViewModel.startPlayback()
                    trackViewModel.startMetronome()
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
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(trackViewModel.isRecording || !audioEngineService.isRunning)
            
            // Clear Button
            Button(action: {
                trackViewModel.clearTrack()
                trackViewModel.stopMetronome()
            }) {
                Image(systemName: "trash.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(!audioEngineService.isRunning)
        }
        .frame(height: 50)
        .padding()
    }
}
