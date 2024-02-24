//
//  MetronomeView.swift
//
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI

struct MetronomeView: View {
    @ObservedObject var trackViewModel: TrackViewModel
    @ObservedObject var metronomeViewModel: MetronomeViewModel
    @State private var showingTempoPicker = false
    
    var body: some View {
        HStack {
            Button(action: {
                showingTempoPicker = true
            }) {
                Text("\(metronomeViewModel.tempo) BPM")
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
                    Picker("Tempo", selection: $metronomeViewModel.tempo) {
                        ForEach(40...240, id: \.self) { bpm in
                            Text("\(bpm) BPM").tag(bpm)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .padding()
            }
            
            Button(action: {
                metronomeViewModel.isActivated.toggle()
            }) {
                Image(systemName: "metronome")
                    .foregroundColor(metronomeViewModel.isActivated ? Color.white : Color.black)
                    .padding()
                    .background(metronomeViewModel.isActivated ? Color.black : Color.clear)
                    .cornerRadius(10) 
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    )
            }
        }
    }
}
