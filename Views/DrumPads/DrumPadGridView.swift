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
    
    let numberOfRows: Int = 2
    let numberOfColumns: Int = 4
    let spacing: CGFloat = 25
    
    var body: some View {
        
        GeometryReader { geometry in
            let padWidth = (geometry.size.width - (spacing * CGFloat(numberOfColumns - 1))) / CGFloat(numberOfColumns)
            let padHeight = padWidth

            VStack {
                Spacer()
                VStack(spacing: spacing) {
                    ForEach(0..<numberOfRows, id: \.self) { row in
                        HStack(spacing: spacing) {
                            ForEach(0..<numberOfColumns, id: \.self) { column in
                                let padID = row * numberOfColumns + column
                                DrumPadView(padID: padID, trackViewModel: trackViewModel)
                                    .frame(width: padWidth, height: padHeight)
                            }
                        }
                        .frame(height: padHeight)
                    }
                }
            }
            .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
    }
}
