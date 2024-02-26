//
//  TutorialLiveViewModel.swift
//  
//
//  Created by Jared Drueco on 2024-02-25.
//

import Foundation

class TutorialLiveViewModel: ObservableObject {
    @Published var appViewModel: AppViewModel
    @Published var currentPage: Int = 1
    @Published var currentContent: TutorialModel?
    private lazy var tutorialPages: [TutorialModel] = createTutorialPages()
    
    init(appViewModel: AppViewModel) {
        self.appViewModel = appViewModel
        loadContent(for: currentPage)
    }
    
    private func loadContent(for page: Int) {
        if let content = tutorialPages[safe: page - 1] {
            self.currentContent = content
        }
    }
    
    private func createTutorialPages() -> [TutorialModel] {
        
        return [
            TutorialModel(title: "Recording your Beat",
                          description: "To record and loop a beat, tap the 'REC' button and play the drum pads.\nPress 'REC' again to stop recording before continuing."),
            
            TutorialModel(title: "Playing Your Beat",
                          description: "Hit the 'START' button to hear your beat.\nPress the 'STOP' button before continuing"),
            
            TutorialModel(title: "Erasing Your Track",
                          description: "Made a mistake? No worries!\nYou can erase your track and start over."),
            
            TutorialModel(title: "Configuration your Drum Machine",
                          description: "You can configure and play around with\n'tempo', number of 'bars', and 'metronome' features!"),
            
            TutorialModel(title: "The End",
                          description: "I think you're ready to start producing beats on your own!\nYou can press the 'PLAY' button to exit tutorial mode.")
        ]
    }
    
    
    func getTotalPages() -> Int {
        return tutorialPages.count
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
        else {
            appViewModel.showTutorial()
        }
    }
}

