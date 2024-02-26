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
                
                HStack() {
                    DrumPadGridView(trackViewModel: trackViewModel)
                        .frame(width: geometry.size.width * (leftPortionSize))
                    VStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("OPTIONS")
                                .font(.headline)
                                .foregroundColor(.black)
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.black)
                                .padding([.bottom])
                        }
                        OptionControlView(trackViewModel: trackViewModel)
                        Spacer()
                        Spacer()
                        VStack(alignment: .leading, spacing: 5) {
                            Text("PLAY / REC")
                                .font(.headline)
                                .foregroundColor(.black)
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.black)
                                .padding(.bottom, 25)
                        }
                        PlaybackControlView(trackViewModel: trackViewModel)
                        Spacer()
                    }
                    .padding(40)
                    .frame(width: geometry.size.width * (rightPortionSize))
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: geometry.size.height)
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

