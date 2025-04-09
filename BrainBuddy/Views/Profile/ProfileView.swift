import SwiftUI

struct ProfileView: View {
    @State private var name = "Alex Johnson"
    @State private var email = "alex.j@example.com"
    @State private var notifications = true
    @State private var reducedMotion = false
    @State private var highContrast = false
    @State private var showEditProfile = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile header
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Circle().fill(Color.blue.opacity(0.1)))
                            .accessibilityLabel("Profile picture")
                        
                        Text(name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(email)
                            .foregroundColor(.secondary)
                        
                        Button("Edit Profile") {
                            showEditProfile = true
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.top, 5)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Accessibility Settings
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Accessibility")
                            .font(.headline)
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                        
                        Toggle("Reduce Motion", isOn: $reducedMotion)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .onChange(of: reducedMotion) { newValue in
                                // In a real app, you would persist this setting
//                                UIAccessibility.isReduceMotionEnabled = newValue
                            }
                        
                        Toggle("High Contrast Mode", isOn: $highContrast)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .onChange(of: highContrast) { newValue in
                                // In a real app, you would update UI elements for high contrast
                            }
                        
                        Toggle("Notifications", isOn: $notifications)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Help and Support
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Help & Support")
                            .font(.headline)
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                        
                        Button(action: {
                            // Open FAQ
                        }) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.blue)
                                Text("FAQs")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        }
                        
                        Button(action: {
                            // Contact support
                        }) {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.blue)
                                Text("Contact Support")
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        }
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Sign out button
                    Button(action: {
                        // Sign out action
                    }) {
                        Text("Sign Out")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .accessibilityHint("Logs you out of your account")
                }
                .padding(.vertical)
            }
            .background(Color.gray.opacity(0.1).ignoresSafeArea())
            .navigationTitle("Profile")
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(name: $name, email: $email)
            }
        }
    }
}
