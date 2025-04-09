import SwiftUI

struct Recommendation: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let type: RecommendationType
    let imageName: String
    
    enum RecommendationType: String {
        case activity = "Activity"
        case article = "Article"
        case video = "Video"
        case tip = "Quick Tip"
    }
}

struct RecommendationsView: View {
    @State private var recommendations = [
        Recommendation(
            title: "5-Minute Breathing Exercise",
            description: "A quick breathing technique to help you relax and reduce stress.",
            type: .activity,
            imageName: "lungs.fill"
        ),
        Recommendation(
            title: "Understanding Anxiety in Students",
            description: "Learn about common causes of anxiety among students and effective coping strategies.",
            type: .article,
            imageName: "doc.text.fill"
        ),
        Recommendation(
            title: "Mindfulness for Study Sessions",
            description: "How to incorporate mindfulness into your study routine for better focus and retention.",
            type: .video,
            imageName: "play.rectangle.fill"
        ),
        Recommendation(
            title: "Take a short walk outside",
            description: "Even a 10-minute walk can help clear your mind and improve your mood.",
            type: .tip,
            imageName: "figure.walk"
        ),
        Recommendation(
            title: "Connect with a Friend",
            description: "Social connections are important for mental health - reach out to someone today.",
            type: .activity,
            imageName: "person.2.fill"
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Daily suggestion
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Daily Suggestion")
                            .font(.headline)
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                        
                        DailySuggestionView()
                            .padding(.horizontal)
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Personalized recommendations
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Personalized for You")
                            .font(.headline)
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                        
                        ForEach(recommendations) { recommendation in
                            RecommendationCardView(recommendation: recommendation)
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color.gray.opacity(0.1).ignoresSafeArea())
            .navigationTitle("Recommendations")
        }
    }
}