//
//  TutorialViewModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-25.
//

import Foundation
import Combine

class TutorialViewModel: ObservableObject {
    @Published var appViewModel: AppViewModel
    @Published var currentPage: Int = 1
    @Published var currentContent: TutorialModel?
    private lazy var tutorialPages: [TutorialModel] = createTutorialPages()
    
    private var quarterNoteBeatPattern: [BeatModel]
    private var eighthNoteBeatPattern: [BeatModel]
    
    private var cancellables: Set<AnyCancellable> = []
    
    private func observeTrackViewModel(_ trackViewModel: TrackViewModel) {
        trackViewModel.$isPlaying
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        trackViewModel.$currentBeat
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    private func loadContent(for page: Int) {
        if let content = tutorialPages[safe: page - 1] {
            cancellables.removeAll()
            observeTrackViewModel(content.trackViewModel)
            self.currentContent = content
        }
    }
    
    init(appViewModel: AppViewModel) {
        self.quarterNoteBeatPattern = [
            BeatModel(padID: 7, startTime: 0.0, barNumber: 0),
            BeatModel(padID: 7, startTime: 1.0, barNumber: 0),
            BeatModel(padID: 7, startTime: 2.0, barNumber: 0),
            BeatModel(padID: 7, startTime: 3.0, barNumber: 0)
        ]
        self.eighthNoteBeatPattern = [
            BeatModel(padID: 7, startTime: 0.0, barNumber: 0),
            BeatModel(padID: 7, startTime: 0.5, barNumber: 0),
            BeatModel(padID: 7, startTime: 1.0, barNumber: 0),
            BeatModel(padID: 7, startTime: 1.5, barNumber: 0),
            BeatModel(padID: 7, startTime: 2.0, barNumber: 0),
            BeatModel(padID: 7, startTime: 2.5, barNumber: 0),
            BeatModel(padID: 7, startTime: 3.0, barNumber: 0),
            BeatModel(padID: 7, startTime: 3.5, barNumber: 0)
        ]
        
        self.appViewModel = appViewModel
        loadContent(for: currentPage)
    }
    
    private func createTutorialPages() -> [TutorialModel] {
        let quarterNotesTrackVM = TrackViewModel()
        quarterNotesTrackVM.trackModel.beats = quarterNoteBeatPattern
        
        let eighthNotesTrackVM = TrackViewModel()
        eighthNotesTrackVM.trackModel.beats = eighthNoteBeatPattern
        
        return [
            TutorialModel(title: "Welcome to Rhythm!",
                          description: "'Rhythm' is a drum machine that helps you grasp the theoretical concept of rhythm and also allows you to produce your own beats!\n\n\nYou can skip this tutorial by clicking 'PLAY' in the options.\n\n\nCreated by: Jared Drueco\nSubmitted: 2024 Student Swift Apple Challenge"),
            
            TutorialModel(title: "Chapter 1: Time Signatures",
                          description: "A time signature defines the beat structure in music, indicating how many beats are in each bar and the note value of each beat.\n\n\nFor simplicity, this app uses 4/4 time signature which means there are four quarter-note beats per bar."),
            
            TutorialModel(title: "Chapter 2: Bars and Measures",
                          description: "Bars (aka measures), segment music into sections defined by the time signature. The example shows a single measure in 4/4 time signature where each measure contains 4 beats.\n\n\nThis is something you can control and configure in this app.", showBeatTracker: true, trackViewModel: TrackViewModel()),
            
            TutorialModel(title: "Chapter 3: Understanding Notes",
                          description: "In music, notes represent the duration of sound. There are a lot of notes and different variations, so start with basic notes:\n\n\n- Quarter notes\n\n\n- Eighth notes"),
            
            TutorialModel(title: "Quarter Notes", description: "A quarter note lasts for one beat. In a 4/4 time signature, there are four quarter notes in a bar.", trackViewModel: quarterNotesTrackVM),
            
            TutorialModel(title: "Eighth Notes",
                          description: "An eighth note lasts for half a beat. This means you can fit 8 eighth notes in a 4/4 bar.", trackViewModel: eighthNotesTrackVM),
            
            TutorialModel(title: "Chapter 4: Tempo",
                          description: "Tempo is the speed of the music, measured in beats per minute (BPM). A higher BPM means a faster tempo.\n\n\nThis is something you can control and configure in this app."),
            
            TutorialModel(title: "Chapter 5: Live tutorial",
                          description: "Now that we know the basics of rhythm in a drum machine, let's make our own beat!\n\n\nFollow along to learn how to use a drum machine!"),
        ]
    }
    
    
    func getTotalPages() -> Int {
        return tutorialPages.count
    }
    
    func goToNextPage() {
        if currentPage < getTotalPages() {
            currentPage += 1
            loadContent(for: currentPage)
        } else {
            appViewModel.showTutorialLive()
        }
    }
    
    func goToPreviousPage() {
        if currentPage > 1 {
            currentPage -= 1
            loadContent(for: currentPage)
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
