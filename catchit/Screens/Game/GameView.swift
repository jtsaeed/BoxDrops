import SwiftUI
import SpriteKit
import StoreKit

struct GameView: View {
    
    @AppStorage("highScore") private var highScore: Int = 0
    
    @State private var score = 0
    @State private var hearts = 4
    @State private var fallingBlockSpeed = 500
    
    @Binding var isPlaying: Bool
    
    var isGameInProgress: Bool {
        hearts > 0
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .center) {
                gameSceneView
                
                VStack(spacing: 20) {
                    mainMenuButton
                    retryButton
                }
            }
            
            HeadsUpDisplayView(score: score, hearts: hearts)
        }
        .animation(.spring(), value: hearts)
        .onChange(of: score) { newScore in
            if newScore > highScore {
                highScore = newScore
            }
            if newScore > 50 {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    private var gameSceneView: some View {
        GeometryReader { geometry in
            SpriteView(
                scene: GameScene(
                    size: CGSize(
                        width: geometry.size.width,
                        height: geometry.size.height
                    ),
                    score: $score,
                    hearts: $hearts,
                    fallingBlockSpeed: $fallingBlockSpeed
                )
            )
        }
    }
    
    private var mainMenuButton: some View {
        HydrogenButton(title: "menu", color: Color(.secondary)) {
            isPlaying = false
        }
        .opacity(isGameInProgress ? 0 : 1)
        .scaleEffect(isGameInProgress ? 0.8 : 1)
        .disabled(isGameInProgress)
    }
    
    private var retryButton: some View {
        HydrogenButton(title: "play again", color: .accentColor) {
            score = 0
            hearts = 4
            fallingBlockSpeed = 500
        }
        .opacity(isGameInProgress ? 0 : 1)
        .scaleEffect(isGameInProgress ? 0.8 : 1)
        .disabled(isGameInProgress)
    }
}
