import SwiftUI
import Charts

struct TripDetailView: View {
    let trip: RoadTrip
    @State private var showPercentage = false

    var cumulativeData: [(Date, Int)] {
        let sorted = trip.plates.compactMap { $0.foundDate }.sorted()
        var result: [(Date, Int)] = []
        for (index, date) in sorted.enumerated() {
            result.append((date, index + 1))
        }
        return result
    }

    var body: some View {
        VStack {
            Chart {
                ForEach(Array(cumulativeData.enumerated()), id: \.offset) { index, item in
                    LineMark(
                        x: .value("Time", item.0),
                        y: .value("Count", item.1)
                    )
                    if showPercentage {
                        LineMark(
                            x: .value("Time", item.0),
                            y: .value("Percent", Double(item.1) / Double(trip.totalCount))
                        )
                        .foregroundStyle(.red)
                        .yScale(domain: 0...1)
                    }
                }
            }
            .chartYAxisSecondary(showPercentage ? AxisMarks(position: .leading) : AxisMarks())
            .padding()
            Toggle("Show %", isOn: $showPercentage)
                .padding()
        }
        .navigationTitle(trip.name)
    }
}
