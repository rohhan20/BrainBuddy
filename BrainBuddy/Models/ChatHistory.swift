import Foundation

struct ChatHistory: Codable {
    var messages: [StoredMessage]
    
    struct StoredMessage: Codable, Identifiable {
        var id: UUID
        var content: String
        var isUser: Bool
        var timestamp: Date
        var sentiment: String
        
        init(from chatMessage: ChatMessage) {
            self.id = chatMessage.id
            self.content = chatMessage.content
            self.isUser = chatMessage.isUser
            self.timestamp = chatMessage.timestamp
            self.sentiment = chatMessage.sentiment.rawValue
        }
    }
    
    // Local storage methods
    static func saveChatHistory(_ history: ChatHistory) {
        do {
            let encoder = JSONEncoder()
            let historyData = try encoder.encode(history)
            UserDefaults.standard.set(historyData, forKey: "chatHistory")
        } catch {
            print("Failed to save chat history: \(error)")
        }
    }
    
    static func loadChatHistory() -> ChatHistory {
        guard let historyData = UserDefaults.standard.data(forKey: "chatHistory") else {
            return ChatHistory(messages: [])
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(ChatHistory.self, from: historyData)
        } catch {
            print("Failed to load chat history: \(error)")
            return ChatHistory(messages: [])
        }
    }
}