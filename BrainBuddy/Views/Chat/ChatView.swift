import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
    
    // For emotional analysis
    var sentiment: Sentiment = .neutral
    
    enum Sentiment: String {
        case veryPositive = "Very Positive"
        case positive = "Positive"
        case neutral = "Neutral"
        case negative = "Negative"
        case veryNegative = "Very Negative"
        
        var color: Color {
            switch self {
            case .veryPositive: return .green
            case .positive: return .mint
            case .neutral: return .blue
            case .negative: return .orange
            case .veryNegative: return .red
            }
        }
    }
}

struct ChatView: View {
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    @State private var isTyping = false
    
    let sentiments: [ChatMessage.Sentiment] = [
        .veryPositive, .positive, .neutral, .negative, .veryNegative
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Chat message bubbles
                ScrollViewReader { scrollView in
                    ScrollView {
                        LazyVStack {
                            ForEach(messages) { message in
                                ChatBubbleView(message: message)
                            }
                            
                            if isTyping {
                                HStack {
                                    Spacer()
                                    TypingIndicator()
                                        .frame(width: 60, height: 30)
                                        .padding(.leading, 20)
                                        .padding(.trailing, 20)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(20)
                                    Spacer()
                                        .frame(width: 80)
                                }
                                .padding(.top, 8)
                                .id("typingIndicator")
                            }
                        }
                        .padding(.horizontal)
                    }
//                    .onChange(of: messages.count) { _ in
//                        withAnimation {
//                            scrollView.scrollTo(messages.last?.id, anchor: .bottom)
//                        }
//                    }
//                    .onChange(of: isTyping) { _ in
//                        withAnimation {
//                            if isTyping {
//                                scrollView.scrollTo("typingIndicator", anchor: .bottom)
//                            }
//                        }
//                    }
                }
                
                // Message input field
                HStack {
                    TextField("Message", text: $messageText)
                        .padding(12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(20)
                        .accessibilityLabel("Message input field")
                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                    .accessibilityLabel("Send message")
                    .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()
            }
            .navigationTitle("Brain Buddy Chat")
            .onAppear {
                // Add welcome message from bot
                let welcomeMessage = ChatMessage(
                    content: "Hi there! I'm Brain Buddy. How are you feeling today?",
                    isUser: false,
                    timestamp: Date()
                )
                messages.append(welcomeMessage)
            }
        }
    }
    
    func sendMessage() {
        let trimmedText = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        // Add user message
        let userMessage = ChatMessage(
            content: trimmedText,
            isUser: true,
            timestamp: Date()
        )
        messages.append(userMessage)
        messageText = ""
        
        // Simulate chatbot typing
        isTyping = true
        
        // Simulate response after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // Generate mock response and random sentiment for demo
            respondToMessage(userMessage)
            isTyping = false
        }
    }
    
    func respondToMessage(_ userMessage: ChatMessage) {
        // Simple response logic for MVP
        let lowerMessage = userMessage.content.lowercased()
        var response = ""
        
        // Very basic intent detection
        if lowerMessage.contains("hello") || lowerMessage.contains("hi") {
            response = "Hello there! How can I help you today?"
        } else if lowerMessage.contains("sad") || lowerMessage.contains("depress") {
            response = "I'm sorry to hear you're feeling down. Remember that it's okay to not be okay. Would you like to talk about why you're feeling sad?"
        } else if lowerMessage.contains("happy") || lowerMessage.contains("good") {
            response = "I'm glad to hear you're doing well! What's been going well for you lately?"
        } else if lowerMessage.contains("stress") || lowerMessage.contains("anxious") {
            response = "Stress can be difficult to manage. Would you like to try a quick breathing exercise together?"
        } else if lowerMessage.contains("help") {
            response = "I'm here to help. You can talk to me about your feelings, ask for advice, or just chat about your day."
        } else if lowerMessage.contains("bye") {
            response = "Goodbye! Remember I'm always here when you need someone to talk to."
        } else {
            response = "Thank you for sharing that. How does this make you feel?"
        }
        
        // Create bot response with random sentiment (for demo)
        let randomSentiment = sentiments.randomElement() ?? .neutral
        let botMessage = ChatMessage(
            content: response,
            isUser: false,
            timestamp: Date(),
            sentiment: randomSentiment
        )
        messages.append(botMessage)
    }
}
