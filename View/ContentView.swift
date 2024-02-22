import SwiftUI

struct ContentView: View {
    let drumSounds = ["clap", "crash", "hihat", "kick", "rattle", "snap", "snare", "tom"]
    var drumSoundModels: [SoundModel] {
        drumSounds.map { SoundModel(soundName: $0) }
    }
    
    var body: some View {
        VStack {
            ForEach(0..<2) { row in
                HStack {
                    ForEach(0..<4) { column in
                        DrumPadView(drumPadViewModel: DrumPadViewModel(soundModel: drumSoundModels[row * 4 + column]))
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
