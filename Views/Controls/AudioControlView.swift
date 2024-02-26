//
//  AudioControlView.swift
//
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI

struct AudioControlView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @EnvironmentObject var audioPlaybackService: AudioPlaybackService
    @EnvironmentObject var appViewModel: AppViewModel
    @ObservedObject var trackViewModel: TrackViewModel
    @State private var showingTempoPicker = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    audioPlaybackService.playSound(named: "click")
                    audioEngineService.isRunning.toggle()
                    trackViewModel.stopPlayback()
                    trackViewModel.stopMetronome()
                    if trackViewModel.isRecording {
                        trackViewModel.isRecording.toggle()
                    }
                    if trackViewModel.isPlaying {
                        trackViewModel.isPlaying.toggle()
                    }
                    if !audioEngineService.isRunning {
                        appViewModel.showIntro()
                        audioEngineService.stopEngine()
                    } else {
                        appViewModel.showTutorial()
                    }
                }) {
                    Image(systemName: "power.circle")
                        .padding(10)
                        .foregroundColor(.black)
                        .background(Color.clear)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1.5)
                        )
                }
                Button(action: {
                    showingTempoPicker = true
                }) {
                    Text("\(trackViewModel.tempo) BPM")
                        .foregroundColor(.primary)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1.5)
                        )
                }
                .popover(isPresented: $showingTempoPicker) {
                    VStack {
                        Text("Select Tempo")
                        Picker("Tempo", selection: $trackViewModel.tempo) {
                            ForEach(40...240, id: \.self) { bpm in
                                Text("\(bpm) BPM").tag(bpm)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                    .padding()
                }
                .disabled(!audioEngineService.isRunning || trackViewModel.isRecording)
                
            }
            
            Stepper("\(trackViewModel.numberOfBars) BAR(S)",
                value: $trackViewModel.numberOfBars,
                in: 1...4
            )
            .disabled(!audioEngineService.isRunning || trackViewModel.isRecording)
            
        }
    }
}
