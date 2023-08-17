import SwiftUI
import SpriteKit

struct GameView: View {
    
    @State var score = 0
    @State var hearts = 4
    @State var fallingBlockSpeed = 500
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.init(white: 0.98, alpha: 1.0))
                .ignoresSafeArea(.container)
            
            ZStack {
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
                
                if hearts <= 0 {
                    HydrogenButton(title: "retry", color: .accentColor, action: retryButtonAction)
                }
            }
            
            HeadsUpDisplayView(score: score, hearts: hearts)
        }
    }
    
    private func retryButtonAction() {
        score = 0
        hearts = 4
        fallingBlockSpeed = 500
    }
}

struct HeadsUpDisplayView: View {
    
    let score: Int
    let hearts: Int
    
    var body: some View {
        HStack(spacing: 8) {
            HeadsUpDisplayPillView {
                HStack(spacing: 4) {
                    Text("score")
                        .fontWeight(.light)
                    Text(score.description)
                        .fontWeight(.semibold)
                }
            }
            
            if hearts > 0 {
                HeadsUpDisplayPillView {
                    HStack {
                        ForEach(0 ..< hearts, id: \.self) { amount in
                            Image(systemName: "heart.fill")
                        }
                        ForEach(hearts ..< 4, id: \.self) { amount in
                            Image(systemName: "heart.slash")
                        }
                    }
                }
            }
        }
        .font(.title2)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(Color(.init(white: 0.98, alpha: 1.0)))
    }
}

struct HeadsUpDisplayPillView<Content: View>: View {
    
    private let content: () -> Content
    
    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    var body: some View {
        content()
            .foregroundColor(Color(.init(white: 0.32, alpha: 1.0)))
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(Color(.init(white: 0.95, alpha: 1.0)))
            .cornerRadius(16)
    }
}
