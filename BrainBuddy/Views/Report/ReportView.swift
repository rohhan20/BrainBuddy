import SwiftUI
import Charts

struct EmotionData: Identifiable {
    let id = UUID()
    let date: Date
    let score: Double
    let sentiment: String
}

struct ReportView: View {
    // Mock data for demo
    @State private var weeklyData: [EmotionData] = [
        EmotionData(date: Date().addingTimeInterval(-6*86400), score: 0.2, sentiment: "Negative"),
        EmotionData(date: Date().addingTimeInterval(-5*86400), score: 0.1, sentiment: "Very Negative"),
        EmotionData(date: Date().addingTimeInterval(-4*86400), score: 0.5, sentiment: "Neutral"),
        EmotionData(date: Date().addingTimeInterval(-3*86400), score: 0.7, sentiment: "Positive"),
        EmotionData(date: Date().addingTimeInterval(-2*86400), score: 0.6, sentiment: "Positive"),
        EmotionData(date: Date().addingTimeInterval(-1*86400), score: 0.4, sentiment: "Neutral"),
        EmotionData(date: Date(), score: 0.8, sentiment: "Very Positive"),
    ]
    
    @State private var topEmotions = [
        ("Happy", 43),
        ("Calm", 27),
        ("Anxious", 16),
        ("Tired", 14)
    ]
    
    @State private var selectedTimeFrame = 1
    let timeFrames = ["Daily", "Weekly", "Monthly"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Time frame picker
                    Picker("Time Frame", selection: $selectedTimeFrame) {
                        ForEach(0..<timeFrames.count) { index in
                            Text(timeFrames[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    // Mood trend card
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Mood Trend")
                            .font(.headline)
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                        
                        ChartView(weeklyData: weeklyData)
                            .frame(height: 250)
                            .padding(.horizontal)
                            .accessibilityLabel("Mood trend chart showing your emotional patterns")
                            .accessibilityHint("Your mood has been improving over the last 7 days")
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Top emotions
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Top Emotions")
                            .font(.headline)
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                        
                        EmotionBarsView(emotions: topEmotions)
                            .frame(height: 200)
                            .padding(.horizontal)
                            .accessibilityLabel("Top emotions chart")
                    }
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Daily insights
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Daily Insights")
                            .font(.headline)
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                        
                        Text("You're feeling better today compared to yesterday. Your conversations have shown a 15% increase in positive sentiment.")
                            .padding(.horizontal)
                        
                        Text("Key topics in your recent chats:")
                            .font(.subheadline)
                            .padding(.top, 5)
                            .padding(.horizontal)
                        
                        // Topic pills
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(["School", "Friends", "Homework", "Weekend Plans", "Stress"], id: \.self) { topic in
                                    Text(topic)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(20)
                                }
                            }
                            .padding(.horizontal)
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
            .navigationTitle("Emotional Report")
        }
    }
}