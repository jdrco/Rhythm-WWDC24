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



