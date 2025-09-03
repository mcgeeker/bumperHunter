import SwiftUI

struct ContentView: View {
    @StateObject private var store = TripStore()

    var body: some View {
        NavigationStack {
            Group {
                if store.activeTrip != nil {
                    ActiveTripView()
                } else {
                    startScreen
                }
            }
        }
        .environmentObject(store)
    }

    var startScreen: some View {
        VStack {
            NavigationLink("New Trip") {
                NewTripView()
            }
            NavigationLink("History") {
                HistoryView()
            }
            // Settings could go here
        }
        .navigationTitle("Bumper Hunter")
    }
}

#Preview {
    ContentView()
}
