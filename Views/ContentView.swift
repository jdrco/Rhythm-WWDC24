import SwiftUI

struct ContentView: View {
    let trackViewModel = TrackViewModel(tempo: 100, numberOfBars: 1)

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
                    MetronomeView(viewModel: MetronomeViewModel())
                    PlayRecView(viewModel: trackViewModel)
                }
                .frame(width: geometry.size.width / 3)
                .frame(minHeight: geometry.size.height)
            }
        }
        .padding(30)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

