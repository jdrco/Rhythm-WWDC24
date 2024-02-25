//
//  AppViewModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-25.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var currentScreen: Screen = .intro
    
    enum Screen {
        case intro, play, tutorial
    }
    
    // Functions to change the screen
    func showIntro() {
        currentScreen = .intro
    }
    
    func showPlay() {
        currentScreen = .play
    }
    
    func showTutorial() {
        currentScreen = .tutorial
    }
}
