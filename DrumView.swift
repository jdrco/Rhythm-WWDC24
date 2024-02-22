//
//  DrumView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-21.
//

import Foundation
import SwiftUI

struct DrumView: View {
    @ObservedObject var viewModel: SoundViewModel
    @State private var isPressed = false
    
    var body: some View {
        Text(viewModel.soundName.uppercased())
            .foregroundColor(.black)
            .bold()
            .frame(width: 100, height: 100)
            .background(Color.white)
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
                // Optionally, you can handle .onEnded if you want to do something when the press is released
            )
    }
}
