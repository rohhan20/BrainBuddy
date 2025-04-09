import SwiftUI

@main
struct BrainBuddyApp: App {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .onAppear {
                    // Configure initial settings
                    configureAppSettings()
                }
        }
    }
    
    private func configureAppSettings() {
        // Configure initial app settings only on first launch
        if isFirstLaunch {
            // Set default app settings
            isFirstLaunch = false
            
            // Initialize any needed data
            // In a real app, you might set up Core Data, CloudKit, etc.
        }
    }
}