import SwiftUI

struct ActiveTripView: View {
    @EnvironmentObject var store: TripStore
    @State private var sortAscending = true
    @State private var consolidate = false

    var sortedPlates: [PlateRecord] {
        guard let trip = store.activeTrip else { return [] }
        let records = trip.plates.sorted { sortAscending ? $0.plate.displayName < $1.plate.displayName : $0.plate.displayName > $1.plate.displayName }
        if consolidate {
            return records
        } else {
            return records
        }
    }

    var body: some View {
        if let trip = store.activeTrip {
            VStack(alignment: .leading) {
                Text(trip.name)
                    .font(.title)
                Text(trip.startDate, style: .date) + Text(" - ") + Text(trip.endDate, style: .date)
                    .font(.subheadline)
                List {
                    Section("Found") {
                        ForEach(sortedPlates.filter { $0.foundDate != nil }) { record in
                            HStack {
                                Text(record.plate.displayName)
                                Spacer()
                                if let date = record.foundDate {
                                    Text(date, style: .time)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    Section("Remaining") {
                        ForEach(sortedPlates.filter { $0.foundDate == nil }) { record in
                            Button {
                                store.complete(plate: record.plate)
                            } label: {
                                HStack {
                                    Image(systemName: "square")
                                    Text(record.plate.displayName)
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { sortAscending.toggle() }) {
                            Label("Reverse Sort", systemImage: sortAscending ? "arrow.down" : "arrow.up")
                        }
                        Button(action: { consolidate.toggle() }) {
                            Label("Consolidate", systemImage: consolidate ? "checkmark.square" : "square")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Finish Trip") {
                        store.finishActiveTrip()
                    }
                }
            }
        } else {
            Text("No active trip")
        }
    }
}
