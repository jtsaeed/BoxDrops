import SwiftUI

struct MainMenuView: View {
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @AppStorage("highScore") private var highScore: Int = 0
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            tutorialView
            playButton
            footerView
        }
    }
    
    private var tutorialView: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(FallingBlock.allCases, id: \.self) { block in
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(Color(block.color))
                        .frame(width: 24, height: 24)
                    
                    Text(block.description)
                        .font(.title.weight(.light))
                        .opacity(colorScheme == .dark ? 0.8 : 0.5)
                }
            }
        }
    }
    
    private var playButton: some View {
        HydrogenButton(title: "play", color: Color(.accent)) {
            isPlaying = true
        }
    }
    
    private var footerView: some View {
        VStack(spacing: 8) {
            Text("high score • ") + Text(highScore.description).fontWeight(.regular)
        }
        .font(.title2.weight(.light))
        .opacity(colorScheme == .dark ? 0.4 : 0.2)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(isPlaying: .constant(false))
    }
}
