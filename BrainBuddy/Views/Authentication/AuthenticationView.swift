import SwiftUI

struct AuthenticationView: View {
    @Binding var isAuthenticated: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var isLogin = true
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.3)]), 
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    // Logo/Header
                    VStack {
                        Image(systemName: "brain.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.purple)
                            .accessibilityLabel("Brain Buddy logo")
                        
                        Text("Brain Buddy")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                    }
                    .padding(.bottom, 50)
                    .scaleEffect(isLoading ? 1.05 : 1.0)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isLoading)
                    
                    // Form fields
                    VStack(spacing: 20) {
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .accessibilityLabel("Email input field")
                            
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .accessibilityLabel("Password input field")
                            
                        if !isLogin {
                            // Additional sign up fields would go here
                        }
                        
                        Button(action: handleAuthentication) {
                            HStack {
                                Spacer()
                                Text(isLogin ? "Login" : "Sign Up")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
                        .accessibilityHint(isLogin ? "Tap to login" : "Tap to create account")
                        
                        Button(action: { isLogin.toggle() }) {
                            Text(isLogin ? "Need an account? Sign up" : "Already have an account? Login")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    if showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                            .accessibilityLabel("Error message: \(errorMessage)")
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white.opacity(0.8))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal, 20)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            isLoading = true
        }
    }
    
    func handleAuthentication() {
        // For MVP, just simulate authentication
        withAnimation(.spring()) {
            // In a real app, implement actual authentication logic here
            isAuthenticated = true
        }
    }
}