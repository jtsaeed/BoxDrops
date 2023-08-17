import SwiftUI

struct MainMenuView: View {
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button("Play", action: playButtonAction)
            .font(.largeTitle)
    }
    
    private func playButtonAction() {
        isPlaying = true
    }
}
