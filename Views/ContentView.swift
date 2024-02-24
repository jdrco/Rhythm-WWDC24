import SwiftUI

struct ContentView: View {
    @EnvironmentObject var audioEngineService: AudioEngineService
    @EnvironmentObject var audioPlaybackService: AudioPlaybackService
    let trackViewModel = TrackViewModel(tempo: 60, numberOfBars: 1)
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    MainScreenView()
                        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
                    DrumPadGridView(trackViewModel: trackViewModel)
                        .frame(minHeight: 0, maxHeight: .infinity, alignment: .bottom)
                }
                .frame(width: geometry.size.width * 2 / 3)
                .frame(minHeight: geometry.size.height)
                
                VStack(alignment: .center) {
                    Button(action: {
                        audioPlaybackService.playSound(named: "click")
                        audioEngineService.isRunning.toggle()
                    }) {
                        Image(systemName: "power.circle")
                            .padding(10)
                            .foregroundColor(.black)
                            .background(Color.clear)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 2)
                            )
                    }
                    MetronomeView(trackViewModel: trackViewModel)
                    PlayRecView(trackViewModel: trackViewModel)
                }
                .frame(width: geometry.size.width / 3)
                .frame(minHeight: geometry.size.height)
            }
        }
        .padding(40)
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
            .edgesIgnoringSafeArea(.all)
    }
}

