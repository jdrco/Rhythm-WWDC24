import SwiftUI

struct ContentView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @EnvironmentObject var audioPlaybackService: AudioPlaybackService
    let trackViewModel = TrackViewModel()
    let leftPortionSize = 0.64
    let rightPortionSize = 0.36
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack() {
                    ContainerScreenView(trackViewModel: trackViewModel)
                        .frame(width: geometry.size.width * (leftPortionSize))
                    AudioControlView(trackViewModel: trackViewModel)
                        .frame(width: geometry.size.width * (rightPortionSize))
                }
                .frame(maxWidth: .infinity)
                .border(Color.red, width: 1)
                
                HStack() {
                    DrumPadGridView(trackViewModel: trackViewModel)
                        .frame(width: geometry.size.width * (leftPortionSize))
                    VStack {
                        OptionControlView(trackViewModel: trackViewModel)
                        PlaybackControlView(trackViewModel: trackViewModel)
                    }
                    .frame(width: geometry.size.width * (rightPortionSize))
                }
                .frame(maxWidth: .infinity)
                .border(Color.red, width: 1)
            }
            .frame(maxHeight: geometry.size.height)
            .border(Color.blue, width: 1)
        }
        .padding(50)
        .environment(\.font, .system(size: 14, weight: .light, design: .monospaced))
        .edgesIgnoringSafeArea(.all)
        .environment(\.colorScheme, .light)
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
            .edgesIgnoringSafeArea(.all)
    }
}

