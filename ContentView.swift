import SwiftUI

struct ContentView: View {
    let padSounds = ["clap", "crash", "hihat", "kick", "rattle", "snap", "snare", "tom"]
    
    var body: some View {
        VStack {
            ForEach(0..<2) { row in
                HStack {
                    ForEach(0..<4) { column in
                        DrumView(viewModel: SoundViewModel(soundName: padSounds[row * 4 + column]))
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
