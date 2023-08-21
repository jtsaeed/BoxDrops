import SwiftUI

@main
struct BoxChaseApp: App {
    
    @State private var isPlaying: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color(.margin)
                    .ignoresSafeArea(.container)
                
                MainMenuView(isPlaying: $isPlaying)
                    .opacity(isPlaying ? 0 : 1)
                    .disabled(isPlaying)
                
                if isPlaying {
                    GameView(isPlaying: $isPlaying)
                }
            }
            .animation(.spring(), value: isPlaying)
        }
    }
}
