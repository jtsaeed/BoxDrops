import SwiftUI
import SpriteKit

struct GameView: View {
    
    @State var score = 0
    @State var hearts = 4
    @State var fallingBlockSpeed = 500
    
    var isGameInProgress: Bool {
        hearts > 0
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.margin)
                .ignoresSafeArea(.container)
            
            ZStack {
                gameSceneView
                retryButton
            }
            
            HeadsUpDisplayView(score: score, hearts: hearts)
        }
        .animation(.spring(), value: hearts)
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
    
    private var retryButton: some View {
        HydrogenButton(title: "retry", color: .accentColor) {
            score = 0
            hearts = 4
            fallingBlockSpeed = 500
        }
        .opacity(isGameInProgress ? 0 : 1)
        .scaleEffect(isGameInProgress ? 0.8 : 1)
        .disabled(isGameInProgress)
    }
}
