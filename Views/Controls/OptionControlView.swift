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
    @EnvironmentObject var appViewModel: AppViewModel
    @ObservedObject var trackViewModel: TrackViewModel
    @State private var showingTempoPicker = false
    
    var body: some View {
        HStack {
            Button(action: {
                appViewModel.showTutorial()
            }) {
                Text("LEARN")
                    .foregroundColor(appViewModel.currentScreen == AppViewModel.Screen.tutorial || appViewModel.currentScreen == AppViewModel.Screen.tutorialLive ? Color.white : Color.black)
                    .padding()
                    .background(appViewModel.currentScreen == AppViewModel.Screen.tutorial || appViewModel.currentScreen == AppViewModel.Screen.tutorialLive ? Color.black : Color.clear)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1.5)
                    )
            }
            .disabled(!audioEngineService.isRunning)
            
            Button(action: {
                appViewModel.showPlay()
            }) {
                Text("PLAY")
                    .foregroundColor(appViewModel.currentScreen == AppViewModel.Screen.play ? Color.white : Color.black)
                    .padding()
                    .background(appViewModel.currentScreen == AppViewModel.Screen.play ? Color.black : Color.clear)
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


