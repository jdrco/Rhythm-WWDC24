//
//  MainScreenView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-20.
//

import SwiftUI

struct MainScreenView: View {
    var body: some View {
        ZStack {
            Color.cyan
                .frame(height: 300)
                .cornerRadius(10)
            
            Text("Main Screen Content")
                .foregroundColor(.white)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1.5)
        )
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}
