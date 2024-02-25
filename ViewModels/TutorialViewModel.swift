//
//  TutorialViewModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-25.
//

import Foundation

class TutorialViewModel: ObservableObject {
    @Published var currentPage: Int = 1
    @Published var currentContent: TutorialModel?

    private let tutorialData: [TutorialModel] = [
        TutorialModel(title: "Welcome to Rhythm!",
                      description: "This app is called 'Rhythm' and is my submission for SSC 2024. It's a drum machine that not only helps you grasp the theoretical concept of rhythm but also allows you to record and play your own beats."),
        
        TutorialModel(title: "Understanding Notes",
                      description: "In music, notes represent the duration of sound. Let's start with basic notes."),
        
        TutorialModel(title: "Quarter Notes",
                      description: "A quarter note lasts for one beat. In a 4/4 time signature, there are four quarter notes in a bar.",
                      imageName: "quarterNote"),
        
        TutorialModel(title: "Eighth Notes",
                      description: "An eighth note lasts for half a beat. This means you can fit eight eighth notes in a 4/4 bar.",
                      imageName: "eighthNote"),
        
        // TODO: Add more notes + images
        
        TutorialModel(title: "Time Signatures",
                      description: "A time signature tells you how many beats are in each bar. 'Rhythm' uses a 4/4 time signature, meaning there are four beats per bar."),
        
        TutorialModel(title: "Bars and Beats",
                      description: "Understanding bars in a 4/4 time signature is crucial. Each bar contains four beats, and the type of note determines how these beats are filled."),
        
        TutorialModel(title: "The Concept of Tempo",
                      description: "Tempo is the speed of the music, measured in beats per minute (BPM). A higher BPM means a faster tempo."),
        
        TutorialModel(title: "Recording Your Beat",
                      description: "To record, simply tap the record button and play the drum pads. Your beats will be recorded in real-time."),
        
        TutorialModel(title: "Playing Your Beat",
                      description: "After recording, hit the play button to hear your creation."),
        
        TutorialModel(title: "Erasing Your Track",
                      description: "Made a mistake? No worries! You can erase your track and start over."),
        
        TutorialModel(title: "Interactive Tutorial: Recording",
                      description: "Let's try recording a beat. Follow the visual cues on the next page to play along."),
        
        TutorialModel(title: "Live Example",
                      description: "Here's a visual guide for when to hit the pads. Try to replicate this rhythm to make your own beat."),
    ]


    init() {
        loadContent(for: currentPage)
    }
    
    func getTotalPages() -> Int {
        return tutorialData.count
    }

    func goToNextPage() {
        if currentPage < getTotalPages() {
            currentPage += 1
            loadContent(for: currentPage)
        }
    }

    func goToPreviousPage() {
        if currentPage > 1 {
            currentPage -= 1
            loadContent(for: currentPage)
        }
    }
    
    private func loadContent(for page: Int) {
        currentContent = tutorialData[safe: page - 1]
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
