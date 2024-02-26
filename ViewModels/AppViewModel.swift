//
//  AppViewModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-25.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var currentScreen: Screen = .intro
    @Published var tutorialViewModel: TutorialTheoryViewModel? = nil
    @Published var tutorialLiveViewModel: TutorialLiveViewModel? = nil
    
    enum Screen {
        case intro, play, tutorialTheory, tutorialLive
    }
    
    func showIntro() {
        currentScreen = .intro
    }
    
    func showPlay() {
        currentScreen = .play
    }
    
    func showTutorial() {
        if tutorialViewModel == nil {
            tutorialViewModel = TutorialTheoryViewModel(appViewModel: self)
        }
        currentScreen = .tutorialTheory
    }
    
    func showTutorialLive() {
        if tutorialLiveViewModel == nil {
            tutorialLiveViewModel = TutorialLiveViewModel(appViewModel: self)
        }
        currentScreen = .tutorialLive
    }
}
