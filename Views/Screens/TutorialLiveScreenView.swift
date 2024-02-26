//
//  TutorialLiveScreenView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-25.
//

import SwiftUI

struct TutorialLiveScreenView: View {
    @ObservedObject var tutorialLiveViewModel: TutorialLiveViewModel
    @ObservedObject var trackViewModel: TrackViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if let content = tutorialLiveViewModel.currentContent {
                VStack(alignment: .center, spacing: 0) {
                    Text(content.title)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 14, weight: .light, design: .monospaced))
                        .padding(5)
                        .border(.white, width: 1)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(content.description)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding([.top])
                }
                .padding(5)
                
                PlayScreenView(trackViewModel: trackViewModel)
                
                HStack(spacing: 0) {
                    Button(action: {
                        tutorialLiveViewModel.goToPreviousPage()
                    }) {
                        Text("PREV")
                            .frame(maxWidth: .infinity)
                            .frame(height: 25)
                            .contentShape(Rectangle())
                            .foregroundStyle(Color.black)
                    }
                    .background(Color.gray)
                    .disabled(trackViewModel.isRecording || trackViewModel.isPlaying)
                    
                    Button(action: {
                        tutorialLiveViewModel.goToNextPage()
                    }) {
                        Text("NEXT")
                            .frame(maxWidth: .infinity)
                            .frame(height: 25)
                            .contentShape(Rectangle())
                            .foregroundStyle(Color.black)
                    }
                    .background(Color.orange)
                    .disabled(trackViewModel.isRecording || trackViewModel.isPlaying)
                }
            }
        }
    }
}

