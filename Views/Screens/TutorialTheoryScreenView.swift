//
//  TutorialTheoryScreenView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-24.
//

import SwiftUI

struct TutorialTheoryScreenView: View {
    @ObservedObject var tutorialViewModel: TutorialTheoryViewModel
    
    var body: some View {
        VStack {
            
            if let content = tutorialViewModel.currentContent {
                VStack(alignment: .leading) {
                    Text(content.title)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 16, weight: .light, design: .monospaced))
                        .padding(5)
                        .border(.white, width: 1)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(content.description)
                        .foregroundStyle(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                
                VStack(alignment: .center, spacing: 30) {
                    if !content.trackViewModel.trackModel.beats.isEmpty || content.showBeatTracker {
                        BeatTracker(trackViewModel: content.trackViewModel)
                    }
                    if !content.trackViewModel.trackModel.beats.isEmpty {
                        Button(action: {
                            if content.trackViewModel.isPlaying {
                                content.trackViewModel.stopPlayback()
                                content.trackViewModel.resetMetronome()
                            } else {
                                content.trackViewModel.loopPlayback()
                                content.trackViewModel.startMetronome()
                            }
                        }) {
                            Text(content.trackViewModel.isPlaying ? "Stop" : "Play")
                                .frame(height: 25)
                                .contentShape(Rectangle())
                                .foregroundStyle(Color.white)
                                .padding(5)
                                .border(.white, width: 1)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                HStack(spacing: 0) {
                    Button(action: {
                        if content.trackViewModel.isPlaying {
                            content.trackViewModel.stopPlayback()
                            content.trackViewModel.resetMetronome()
                        }
                        tutorialViewModel.goToPreviousPage()
                    }) {
                        Text("PREV")
                            .frame(maxWidth: .infinity)
                            .frame(height: 25)
                            .contentShape(Rectangle())
                            .foregroundStyle(Color.black)
                    }
                    .background(Color.gray)
                    
                    Button(action: {
                        if content.trackViewModel.isPlaying {
                            content.trackViewModel.stopPlayback()
                            content.trackViewModel.resetMetronome()
                        }
                        tutorialViewModel.goToNextPage()
                    }) {
                        Text("NEXT")
                            .frame(maxWidth: .infinity)
                            .frame(height: 25)
                            .contentShape(Rectangle())
                            .foregroundStyle(Color.black)
                    }
                    .background(Color.orange)
                }
            }
        }
    }
}
