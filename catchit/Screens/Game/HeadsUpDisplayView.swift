import SwiftUI

struct HeadsUpDisplayView: View {
    
    let score: Int
    let hearts: Int
    
    var isGameInProgress: Bool {
        hearts > 0
    }
    
    var body: some View {
        HStack(spacing: 8) {
            HeadsUpDisplayPillView(large: !isGameInProgress) {
                HStack(spacing: isGameInProgress ? 4 : 8) {
                    Text("score")
                        .fontWeight(isGameInProgress ? .light : .thin)
                    Text(score.description)
                        .fontWeight(.semibold)
                }
            }
            
            if isGameInProgress {
                HeadsUpDisplayPillView(large: false) {
                    HStack {
                        ForEach(0 ..< hearts, id: \.self) { amount in
                            Image(systemName: "heart.fill")
                        }
                        ForEach(hearts ..< 4, id: \.self) { amount in
                            Image(systemName: "heart.slash")
                        }
                    }
                    .foregroundColor(Color(.pillText))
                }
            }
        }
        .padding(.vertical, isGameInProgress ? 16 : 24)
        .frame(maxWidth: .infinity)
        .background(Color(.margin))
    }
}

struct HeadsUpDisplayPillView<Content: View>: View {
    
    private let large: Bool
    private let content: () -> Content
    
    init(
        large: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.large = large
        self.content = content
    }
    
    var body: some View {
        content()
            .font(large ? .largeTitle : .title2)
            .foregroundColor(Color(.pillText))
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(Color(.pillBackground))
            .cornerRadius(16)
    }
}
