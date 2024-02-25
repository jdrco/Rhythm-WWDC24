//
//  DrumView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-21.
//

import Foundation
import SwiftUI

struct DrumPadView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    let padID: Int
    @ObservedObject var trackViewModel: TrackViewModel
    @State private var isPressed = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            ZStack {
                // Square shape
                Rectangle()
                    .foregroundColor(isPressed ? Color.gray : Color.white)
                    .frame(width: size, height: size)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 1.5)
                    )
                
                // Text placed on top of the square
                Text(AudioConfig.mapPadIDToDrumFile(padID).uppercased())
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 0, y: -(size / 2) - 10)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if isPressed == false && audioEngineService.isRunning {
                            isPressed = true
                            trackViewModel.trackPlayedSound(padID: padID)
                        }
                    }
                    .onEnded { _ in isPressed = false }
            )
        }
    }
}
