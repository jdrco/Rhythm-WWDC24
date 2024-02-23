//
//  DrumPadGridView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-22.
//

import Foundation
import SwiftUI

struct DrumPadGridView: View {
    let trackViewModel: TrackViewModel
    
    let drumSounds = ["clap", "crash", "hihat", "kick", "rattle", "snap", "snare", "tom"]
    var drumSoundModels: [SoundModel] {
        drumSounds.map { SoundModel(soundName: $0) }
    }
    let numberOfRows: Int = 2
    let numberOfColumns: Int = 4
    let spacing: CGFloat = 10
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                let width = (geometry.size.width - (spacing * CGFloat(numberOfColumns - 1))) / CGFloat(numberOfColumns)
                let padHeight = width
                
                VStack(spacing: spacing) {
                    ForEach(0..<numberOfRows, id: \.self) { row in
                        HStack(spacing: spacing) {
                            ForEach(0..<numberOfColumns, id: \.self) { column in
                                let padID = row * numberOfColumns + column
                                DrumPadView(viewModel: DrumPadViewModel(padID: padID, soundModel: drumSoundModels[padID], trackViewModel: trackViewModel))
                                    .frame(width: width, height: padHeight)
                            }
                        }
                        .frame(height: padHeight)
                    }
                }
            }
        }
    }
}