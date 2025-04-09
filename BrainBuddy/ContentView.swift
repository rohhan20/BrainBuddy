import SwiftUI

struct ContentView: View {
    @State private var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            MainTabView()
        } else {
            AuthenticationView(isAuthenticated: $isAuthenticated)
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "bubble.left.and.bubble.right.fill")
                }
                .accessibilityLabel("Chat tab")
            
            ReportView()
                .tabItem {
                    Label("Report", systemImage: "chart.line.uptrend.xyaxis")
                }
                .accessibilityLabel("Emotional report tab")
            
            RecommendationsView()
                .tabItem {
                    Label("For You", systemImage: "hand.thumbsup.fill")
                }
                .accessibilityLabel("Recommendations tab")
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .accessibilityLabel("Profile tab")
        }
        .accentColor(.blue)
    }
}

#Preview{
    ContentView()
}
