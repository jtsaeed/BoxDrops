import SwiftUI

struct MainMenuView: View {
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text("catch")
            }
            .font(.title.weight(.light))
            .opacity(0.6)
            
            HydrogenButton(title: "play", color: Color("PlayerBlock"), action: playButtonAction)
        }
    }
    
    private func playButtonAction() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        isPlaying = true
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(isPlaying: .constant(false))
    }
}
