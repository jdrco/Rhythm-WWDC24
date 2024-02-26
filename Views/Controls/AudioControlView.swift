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
    @State private var showingBarPicker = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 5) {
                Text("RHYHTM - A DRUM MACHINE")
                    .font(.headline)
                    .foregroundColor(.black)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.black)
                    .padding(.bottom, 25)
            }
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
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .background(Circle().fill(audioEngineService.isRunning ? Color.green : Color.clear))
                        .padding(30)
                        .overlay(
                            Circle()
                                .stroke(.black, lineWidth: 1.5)
                        )
                }
                
                Spacer()
                
                Button(action: {
                    showingTempoPicker = true
                }) {
                    Text("TEMPO: \(trackViewModel.tempo) BPM")
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
                
                Spacer()
                
                Button(action: {
                    showingBarPicker = true
                }) {
                    Text("# BAR: \(trackViewModel.numberOfBars) BARS")
                        .foregroundColor(.primary)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1.5)
                        )
                }
                .popover(isPresented: $showingBarPicker) {
                    VStack {
                        Text("Select Number of Bars")
                        Picker("Bars", selection: $trackViewModel.numberOfBars) {
                            ForEach(1...4, id: \.self) { bar in
                                Text("\(bar) bars").tag(bar)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                    .padding()
                }
                .disabled(!audioEngineService.isRunning || trackViewModel.isRecording)
            }
        }
        .padding(40)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
