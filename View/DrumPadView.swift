//
//  DrumView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-21.
//

import Foundation
import SwiftUI

struct DrumPadView: View {
    @ObservedObject var viewModel: DrumPadViewModel
    @State private var isPressed = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            Text(viewModel.soundName.uppercased())
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
                                viewModel.playSound()
                            }
                        }
                        .onEnded { _ in isPressed = false }
                )
        }
    }
}

struct DrumPadsContainerView: View {
    let drumSounds = ["clap", "crash", "hihat", "kick", "rattle", "snap", "snare", "tom"]
    var drumSoundModels: [SoundModel] {
        drumSounds.map { SoundModel(soundName: $0) }
    }
    let numberOfRows: Int = 2
    let numberOfColumns: Int = 4
    let spacing: CGFloat = 10
    
    var body: some View {
        VStack {
            Text("DRUMS") // TODO: find a better way to align drums to bottom
                .foregroundColor(Color.clear)
            Spacer()
            GeometryReader { geometry in
                let width = (geometry.size.width - (spacing * CGFloat(numberOfColumns - 1))) / CGFloat(numberOfColumns)
                let padHeight = width
                
                VStack(spacing: spacing) {
                    ForEach(0..<numberOfRows, id: \.self) { row in
                        HStack(spacing: spacing) {
                            ForEach(0..<numberOfColumns, id: \.self) { column in
                                DrumPadView(viewModel: DrumPadViewModel(soundModel: drumSoundModels[row * numberOfColumns + column]))
                                    .frame(width: width, height: padHeight)
                            }
                        }
                        .frame(height: padHeight)
                    }
                }
            }
            .padding(spacing)
        }
    }
}

