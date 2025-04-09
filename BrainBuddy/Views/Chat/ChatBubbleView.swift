import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.content)
                    .padding(12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                Text(message.content)
                    .padding(12)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(16)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                Spacer()
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(message.isUser ? "You said" : "Brain Buddy said")
        .accessibilityValue(message.content)
    }
}

struct TypingIndicator: View {
    @State private var showCircle1 = false
    @State private var showCircle2 = false
    @State private var showCircle3 = false
    
    var body: some View {
        HStack(spacing: 3) {
            Circle()
                .frame(width: 7, height: 7)
                .opacity(showCircle1 ? 1 : 0.5)
                .scaleEffect(showCircle1 ? 1 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: showCircle1)
            
            Circle()
                .frame(width: 7, height: 7)
                .opacity(showCircle2 ? 1 : 0.5)
                .scaleEffect(showCircle2 ? 1 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.2), value: showCircle2)
            
            Circle()
                .frame(width: 7, height: 7)
                .opacity(showCircle3 ? 1 : 0.5)
                .scaleEffect(showCircle3 ? 1 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.4), value: showCircle3)
        }
        .onAppear {
            showCircle1 = true
            showCircle2 = true
            showCircle3 = true
        }
        .accessibilityLabel("Brain Buddy is typing")
    }
}