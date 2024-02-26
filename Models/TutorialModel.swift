//
//  TutorialModel.swift
//  Rhythm-WWDC24
//
//  Created by Jared Drueco on 2024-02-25.
//

import Foundation
import SwiftUI

struct TutorialModel {
    let title: String
    let description: String
    let imageName: String?
    let showBeatTracker: Bool
    var trackViewModel: TrackViewModel
    
    init(title: String, description: String, imageName: String = "", showBeatTracker: Bool = false, trackViewModel: TrackViewModel = TrackViewModel()) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.trackViewModel = trackViewModel
        self.showBeatTracker = showBeatTracker
    }
}

