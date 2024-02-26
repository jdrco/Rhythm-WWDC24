//
//  PlaybackControlView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import SwiftUI

struct PlaybackControlView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @EnvironmentObject var appViewModel: AppViewModel
    @ObservedObject var trackViewModel: TrackViewModel
    
    var body: some View {
        HStack(spacing: 20) {
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
                Text("REC")
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(trackViewModel.isRecording ? .red : .white)
                    .background(trackViewModel.isRecording ? .gray : .red)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(!audioEngineService.isRunning || appViewModel.currentScreen == AppViewModel.Screen.tutorialTheory)
            
            // Start/Stop Button
            Button(action: {
                if trackViewModel.isPlaying {
                    trackViewModel.stopPlayback()
                    trackViewModel.stopMetronome()
                } else {
                    trackViewModel.loopPlayback()
                    trackViewModel.startMetronome()
                }
            }) {
                Text("START")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(trackViewModel.isPlaying ? .white : .black)
                    .background(trackViewModel.isPlaying ? Color.black : Color.clear)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(trackViewModel.isRecording || !audioEngineService.isRunning || appViewModel.currentScreen == AppViewModel.Screen.tutorialTheory)
            
            // Clear Button
            Button(action: {
                trackViewModel.clearTrack()
                trackViewModel.stopMetronome()
            }) {
                Text("CLEAR")
                    .padding()
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.clear)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(!audioEngineService.isRunning || appViewModel.currentScreen == AppViewModel.Screen.tutorialTheory)
        }
        .frame(maxWidth: .infinity)
    }
}
