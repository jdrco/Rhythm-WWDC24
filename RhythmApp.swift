import SwiftUI

@main
struct RhythmApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AudioEngineService.shared)
                .environmentObject(AudioPlaybackService.shared)
                .environmentObject(AppViewModel())
        }
    }
}
