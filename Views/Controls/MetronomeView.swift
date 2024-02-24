//
//  MetronomeView.swift
//
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI

struct MetronomeView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @ObservedObject var trackViewModel: TrackViewModel
    @State private var showingTempoPicker = false
    
    var body: some View {
        HStack {
            Button(action: {
                showingTempoPicker = true
            }) {
                Text("\(trackViewModel.tempo) BPM")
                    .foregroundColor(.primary)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    )
            }
            .popover(isPresented: $showingTempoPicker) {
                VStack {
                    Text("Select Tempo")
                        .font(.headline)
                    Picker("Tempo", selection: $trackViewModel.tempo) {
                        ForEach(40...240, id: \.self) { bpm in
                            Text("\(bpm) BPM").tag(bpm)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .padding()
            }
            .disabled(!audioEngineService.isRunning)
            
            Button(action: {
                trackViewModel.metronomeActivated.toggle()
            }) {
                Image(systemName: "metronome")
                    .foregroundColor(trackViewModel.metronomeActivated ? Color.white : Color.black)
                    .padding()
                    .background(trackViewModel.metronomeActivated ? Color.black : Color.clear)
                    .cornerRadius(10) 
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    )
            }
            .disabled(!audioEngineService.isRunning)
        }
    }
}
