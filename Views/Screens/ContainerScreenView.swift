//
//  IntroScreenView.swift
//
//
//  Created by Jared Drueco on 2024-02-25.
//

import SwiftUI
import Foundation

struct ContainerScreenView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @EnvironmentObject var audioPlaybackService: AudioPlaybackService
    @EnvironmentObject var appViewModel: AppViewModel
    @ObservedObject var trackViewModel: TrackViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .frame(maxHeight: .infinity)
                    .cornerRadius(10)
                
                switch appViewModel.currentScreen {
                case .intro:
                    IntroScreenView()
                case .play:
                    PlayScreenView(trackViewModel: trackViewModel)
                case .tutorialTheory:
                    if let tutorialViewModel = appViewModel.tutorialViewModel {
                        TutorialTheoryScreenView(tutorialViewModel: tutorialViewModel)
                    }
                case .tutorialLive:
                    if let tutorialLiveViewModel = appViewModel.tutorialLiveViewModel {
                        TutorialLiveScreenView(tutorialLiveViewModel: tutorialLiveViewModel, trackViewModel: trackViewModel)
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 1.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.4), lineWidth: 8)
                            .blur(radius: 6)
                            .offset(x: 0, y: 0)
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
    }
    
}

