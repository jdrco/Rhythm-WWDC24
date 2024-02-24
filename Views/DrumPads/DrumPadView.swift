//
//  DrumView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-21.
//

import Foundation
import SwiftUI

struct DrumPadView: View {
    let padID: Int
    @ObservedObject var trackViewModel: TrackViewModel
    @State private var isPressed = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            Text(AudioConfig.mapPadIDToDrumFile(padID))
                .foregroundColor(.black)
                .bold()
                .frame(width: size, height: size)
                .background(isPressed ? Color.gray : Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 2)
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if isPressed == false {
                                isPressed = true
                                trackViewModel.trackPlayedSound(padID: padID)
                            }
                        }
                        .onEnded { _ in isPressed = false }
                )
        }
    }
}



