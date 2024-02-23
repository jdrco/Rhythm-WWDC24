//
//  MetronomeView.swift
//
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI

struct MetronomeView: View {
    @ObservedObject var viewModel: MetronomeViewModel
    @State private var isPressed = false
    @State private var showingTempoPicker = false
    
    var body: some View {
        HStack {
            Button(action: {
                showingTempoPicker = true
            }) {
                Text("\(viewModel.tempo) BPM")
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
                    Picker("Tempo", selection: $viewModel.tempo) {
                        ForEach(40...240, id: \.self) { bpm in
                            Text("\(bpm) BPM").tag(bpm)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .padding()
            }
            
            Button(action: {
                viewModel.toggleMetronome()
                isPressed.toggle()
            }) {
                Image(systemName: "metronome")
                    .foregroundColor(isPressed ? Color.white : Color.black)
                    .padding()
                    .background(isPressed ? Color.black : Color.clear)
                    .cornerRadius(10) 
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    )
            }
            .buttonStyle(PlainButtonStyle())
            .onChange(of: viewModel.isPlaying) { _ in
                isPressed = viewModel.isPlaying
            }
        }
    }
}
