import SwiftUI

struct DailySuggestionView: View {
    @State private var animateGradient = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)],
                        startPoint: animateGradient ? .topLeading : .bottomLeading,
                        endPoint: animateGradient ? .bottomTrailing : .topTrailing
                    )
                )
                .onAppear {
                    withAnimation(.linear(duration: 5).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "sparkles")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Journal Prompt")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                Text("What are three things that made you smile today? Take a moment to reflect on these positive experiences.")
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                
                Button(action: {
                    // Action for when the user wants to respond to the prompt
                }) {
                    Text("Respond in Chat")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.blue.opacity(0.7))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(20)
                }
                .accessibilityHint("Opens chat to respond to journal prompt")
            }
            .padding(20)
        }
        .frame(height: 200)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Daily journal prompt: What are three things that made you smile today?")
    }
}

struct RecommendationCardView: View {
    let recommendation: Recommendation
    
    var body: some View {
        Button(action: {
            // Action for when recommendation is tapped
        }) {
            HStack(spacing: 15) {
                Image(systemName: recommendation.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                    .padding(10)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(recommendation.type.rawValue)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    
                    Text(recommendation.title)
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(recommendation.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(recommendation.type.rawValue): \(recommendation.title)")
        .accessibilityHint(recommendation.description)
    }
}