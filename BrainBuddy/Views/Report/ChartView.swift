import SwiftUI
import Charts

struct ChartView: View {
    let weeklyData: [EmotionData]
    
    var body: some View {
        Chart {
            ForEach(weeklyData) { item in
                LineMark(
                    x: .value("Date", item.date),
                    y: .value("Emotional Score", item.score)
                )
                .foregroundStyle(Color.blue.gradient)
                
                PointMark(
                    x: .value("Date", item.date),
                    y: .value("Emotional Score", item.score)
                )
                .foregroundStyle(by: .value("Sentiment", item.sentiment))
            }
        }
        .chartXAxis {
            AxisMarks(values: weeklyData.map { $0.date }) { date in
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartForegroundStyleScale([
            "Very Positive": .green,
            "Positive": .mint,
            "Neutral": .blue,
            "Negative": .orange,
            "Very Negative": .red
        ])
    }
}

struct EmotionBarsView: View {
    let emotions: [(String, Int)]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<emotions.count, id: \.self) { index in
                let emotion = emotions[index]
                HStack {
                    Text(emotion.0)
                        .frame(width: 70, alignment: .leading)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: geometry.size.width, height: 20)
                                .cornerRadius(5)
                            
                            Rectangle()
                                .fill(Color.blue.opacity(0.8))
                                .frame(width: geometry.size.width * calculateWidth(emotion.1), height: 20)
                                .cornerRadius(5)
                        }
                    }
                    .frame(height: 20)
                    
                    Text("\(emotion.1)%")
                        .frame(width: 40, alignment: .trailing)
                        .font(.caption)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("\(emotion.0): \(emotion.1) percent")
            }
        }
    }
    
    func calculateWidth(_ value: Int) -> CGFloat {
        return CGFloat(value) / 100.0
    }
}