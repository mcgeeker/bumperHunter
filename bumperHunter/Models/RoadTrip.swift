import Foundation

struct RoadTrip: Identifiable, Codable {
    let id: UUID
    var name: String
    var startDate: Date
    var endDate: Date
    var plates: [PlateRecord]

    init(id: UUID = UUID(), name: String, startDate: Date, endDate: Date, plates: [PlateRecord]) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.plates = plates
    }

    var foundCount: Int {
        plates.filter { $0.foundDate != nil }.count
    }

    var totalCount: Int {
        plates.count
    }
}
