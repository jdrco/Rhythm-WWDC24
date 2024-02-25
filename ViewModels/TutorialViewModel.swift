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
        
        TutorialModel(title: "Chapter 1: Understanding Notes",
                      description: "In music, notes represent the duration of sound. There are a lot of notes and different variations, so start with basic notes."),
        
        TutorialModel(title: "Quarter Notes",
                      description: "A quarter note lasts for one beat. In a 4/4 time signature, there are four quarter notes in a bar.",
                      imageName: "quarterNote"),
        
        TutorialModel(title: "Eighth Notes",
                      description: "An eighth note lasts for half a beat. This means you can fit eight eighth notes in a 4/4 bar.",
                      imageName: "eighthNote"),
        
        // TODO: Add more notes + images
        
        TutorialModel(title: "Chapter 2: Time Signatures",
                      description: "A time signature defines the beat structure in music, indicating how many beats are in each bar and the note value of each beat. This app uses 4/4 time signature which means there are four quarter-note beats per bar."),
        
        TutorialModel(title: "Chapter 3: Bars and Measures",
                      description: "Bars (aka measures), segment music into sections defined by the time signature. In a 4/4 time signature, each bar contains four beats. This organization aids musicians in reading music and keeping time, ensuring cohesive rhythm and synchronization during playback or ensemble performance."),

        TutorialModel(title: "Chapter 4: Tempo",
                      description: "Tempo is the speed of the music, measured in beats per minute (BPM). A higher BPM means a faster tempo. Feel free to press the play button with 'tick' set on and change the value of 'tempo' to hear different tempos!"),
        
        TutorialModel(title: "Chapter 5: Let's make some noise!",
                      description: "Now that we know the basics of rhythm, let's make our own beat!"),
        
        TutorialModel(title: "Recording your beat!",
                      description: "To record a beat, simply tap the record button and play the drum pads. Your beats will be recorded in real-time and you can hear it loop."),
        
        TutorialModel(title: "Playing Your Beat",
                      description: "After recording, hit the 'START' button to hear your creation."),
        
        TutorialModel(title: "Erasing Your Track",
                      description: "Made a mistake? No worries! You can erase your track and start over."),
        
        TutorialModel(title: "Chapter 6: Final Challenge",
                      description: "Let's see if you can replicate the following beat. Follow the visual cues on this page to play along."),
        
        TutorialModel(title: "The End",
                      description: "I think you're ready to start producing beats on your own! You can press the 'PLAY' button to start with a fresh canvas."),
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
