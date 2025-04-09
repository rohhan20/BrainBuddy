import Foundation

struct User: Codable {
    var id: String
    var name: String
    var email: String
    var profileImageName: String?
    
    // For local storage purposes
    static func saveCurrentUser(_ user: User) {
        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(user)
            UserDefaults.standard.set(userData, forKey: "currentUser")
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    static func loadCurrentUser() -> User? {
        guard let userData = UserDefaults.standard.data(forKey: "currentUser") else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(User.self, from: userData)
        } catch {
            print("Failed to load user: \(error)")
            return nil
        }
    }
}