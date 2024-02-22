import SwiftUI

struct MainScreenView: View {
    var body: some View {
        ZStack {
            Color.cyan
                .frame(height: 300)
                .cornerRadius(10)
            
            Text("Main Screen Content")
                .foregroundColor(.white)
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 2)
        )
        .padding(10)
    }
}
