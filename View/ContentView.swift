import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                VStack {
                    MainScreenView()
                    DrumPadsContainerView()
                }
                .frame(width: geometry.size.width * 2 / 3)
                .frame(maxHeight: .infinity)
                
                VStack(alignment: .leading) {
                    MetronomeView(viewModel: MetronomeViewModel())
                    Spacer()
                }
                .frame(width: geometry.size.width / 3)
                .frame(maxHeight: .infinity)
                .padding(10)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

