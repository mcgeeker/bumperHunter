import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var store: TripStore

    var body: some View {
        List {
            ForEach(store.history) { trip in
                NavigationLink(destination: TripDetailView(trip: trip)) {
                    VStack(alignment: .leading) {
                        Text(trip.name)
                            .font(.headline)
                        Text("\(trip.startDate, format: .dateTime.year().month().day()) - \(trip.endDate, format: .dateTime.year().month().day())")
                            .font(.caption)
                        Text("\(trip.foundCount) / \(trip.totalCount) plates")
                            .font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle("History")
    }
}
