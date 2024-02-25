//
//  TutorialScreenView.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-24.
//

import SwiftUI

struct TutorialScreenView: View {
    @StateObject var tutorialViewModel = TutorialViewModel()

    var body: some View {
        VStack {
            if let content = tutorialViewModel.currentContent {
                Text(content.title)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 16, weight: .light, design: .monospaced))

                Text(content.description)
                    .foregroundStyle(Color.white)
                    .padding()

                if !content.imageName.isEmpty {
                    Image(content.imageName)
                        .resizable()
                        .scaledToFit()
                } else {
                    Spacer()
                }

                HStack {
                    Button("Previous", action: tutorialViewModel.goToPreviousPage)
                        .disabled(tutorialViewModel.currentPage == 1)

                    Spacer()

                    Button("Next", action: tutorialViewModel.goToNextPage)
                        .disabled(tutorialViewModel.currentPage == tutorialViewModel.getTotalPages())
                }
            }
        }
        .padding()
    }
}
