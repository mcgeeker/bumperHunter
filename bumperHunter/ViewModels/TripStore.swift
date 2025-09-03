import Foundation

@MainActor
class TripStore: ObservableObject {
    @Published var activeTrip: RoadTrip?
    @Published var history: [RoadTrip] = []

    private let activeKey = "activeTrip.json"
    private let historyKey = "history.json"

    init() {
        Task {
            await load()
        }
    }

    func startNewTrip(name: String, startDate: Date, endDate: Date, plates: [LicensePlate]) {
        let records = plates.map { PlateRecord(plate: $0) }
        let trip = RoadTrip(name: name, startDate: startDate, endDate: endDate, plates: records)
        self.activeTrip = trip
        save()
    }

    func complete(plate: LicensePlate) {
        guard var trip = activeTrip else { return }
        if let idx = trip.plates.firstIndex(where: { $0.plate.id == plate.id }) {
            trip.plates[idx].foundDate = Date()
            activeTrip = trip
            save()
        }
    }

    func finishActiveTrip() {
        guard let trip = activeTrip else { return }
        history.append(trip)
        activeTrip = nil
        save()
    }

    private func fileURL(for key: String) -> URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return dir.appendingPathComponent(key)
    }

    func save() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let trip = activeTrip {
            let url = fileURL(for: activeKey)
            try? encoder.encode(trip).write(to: url)
        }
        let historyURL = fileURL(for: historyKey)
        try? encoder.encode(history).write(to: historyURL)
    }

    func load() async {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let activeURL = fileURL(for: activeKey)
        if let data = try? Data(contentsOf: activeURL),
           let trip = try? decoder.decode(RoadTrip.self, from: data) {
            activeTrip = trip
        }
        let historyURL = fileURL(for: historyKey)
        if let data = try? Data(contentsOf: historyURL),
           let trips = try? decoder.decode([RoadTrip].self, from: data) {
            history = trips
        }
    }
}
