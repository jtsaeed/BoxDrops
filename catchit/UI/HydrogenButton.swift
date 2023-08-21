import SwiftUI

struct HydrogenButton: View {
    
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(HydrogenButtonStyle(color: color))
    }
}

struct HydrogenButtonStyle: ButtonStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(0.98)
            .font(.largeTitle.weight(.light))
            .foregroundColor(.white)
            .padding(.horizontal, 64)
            .padding(.vertical, 16)
            .background(color)
            .cornerRadius(16)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.linear(duration: 0.25), value: configuration.isPressed)
    }
}

struct HydrogenButton_Previews: PreviewProvider {
    static var previews: some View {
        HydrogenButton(title: "Play", color: Color("PlayerBlock"), action: {})
    }
}
