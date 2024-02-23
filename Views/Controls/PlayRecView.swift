//
//  PlayRecView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import SwiftUI

struct PlayRecView: View {
    @ObservedObject var viewModel: TrackViewModel
    
    var body: some View {
        VStack {
            HStack {
                // Record Button
                Button(action: {
                    viewModel.toggleRecording()
                }) {
                    Image(systemName: viewModel.isRecording ? "stop.circle" : "record.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .foregroundColor(viewModel.isRecording ? .red : .black)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                
                // Play Button
                Button(action: {
                    viewModel.startPlayback()
                }) {
                    Image(systemName: "play.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .foregroundColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                .disabled(viewModel.isPlaying || viewModel.isRecording)
                
                // Stop Button
                Button(action: {
                    viewModel.stopPlayback()
                }) {
                    Image(systemName: "stop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .foregroundColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                .disabled(!viewModel.isPlaying)
                
                // Clear Button
                Button(action: {
                    viewModel.clearTrack()
                }) {
                    Image(systemName: "trash.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .foregroundColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
            }
            .frame(height: 50)
            .padding()
        }
    }
}
