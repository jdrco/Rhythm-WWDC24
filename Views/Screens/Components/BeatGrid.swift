//
//  BeatGrid.swift
//
//
//  Created by Jared Drueco on 2024-02-24.
//

import SwiftUI

struct BeatGrid: View {
    let numberOfBeats: Int = AudioConfig.drumFiles.count

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<numberOfBeats, id: \.self) { _ in
                Divider()
                    .background(Color.black)
                Spacer()
            }
        }
    }
}

