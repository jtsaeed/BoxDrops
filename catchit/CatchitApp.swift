import SwiftUI

@main
struct CatchitApp: App {
    
    @State private var isPlaying: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isPlaying {
                GameView()
            } else {
                MainMenuView(isPlaying: $isPlaying)
            }
        }
    }
}
