//
//  OptionControlView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI

struct OptionControlView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @EnvironmentObject var audioPlaybackService: AudioPlaybackService
    @ObservedObject var trackViewModel: TrackViewModel
    @State private var showingTempoPicker = false
    
    var body: some View {
        HStack {
            Button(action: {
                // TODO: Learn mode
            }) {
                Text("LEARN")
                    .foregroundColor(Color.black)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(10) 
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(!audioEngineService.isRunning)
            
            Button(action: {
                // TODO: Play mode
            }) {
                Text("PLAY")
                    .foregroundColor(Color.black)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(10) 
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(!audioEngineService.isRunning)
            
            Button(action: {
                trackViewModel.metronomeActivated.toggle()
            }) {
                Text("TICK")
                    .foregroundColor(trackViewModel.metronomeActivated ? Color.white : Color.black)
                    .padding()
                    .background(trackViewModel.metronomeActivated ? Color.black : Color.clear)
                    .cornerRadius(10) 
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(!audioEngineService.isRunning)
        }
    }
}


