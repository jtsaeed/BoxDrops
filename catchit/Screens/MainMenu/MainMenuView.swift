import SwiftUI

struct MainMenuView: View {
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        ZStack {
            Color(.init(white: 0.98, alpha: 1.0))
                .ignoresSafeArea(.container)
            
            VStack(spacing: 32) {
                tutorialView
                playButton
                footerView
            }
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
                        .foregroundColor(.black)
                        .font(.title.weight(.light))
                        .opacity(0.5)
                }
            }
        }
    }
    
    private var playButton: some View {
        HydrogenButton(title: "play", color: Color(.accent)) {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            isPlaying = true
        }
    }
    
    private var footerView: some View {
        VStack(spacing: 8) {
            Text("BoxDrops • beta 2")
        }
        .foregroundColor(.black)
        .font(.title2.weight(.light))
        .opacity(0.2)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(isPlaying: .constant(false))
    }
}
