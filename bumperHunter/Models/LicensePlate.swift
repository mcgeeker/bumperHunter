import Foundation

struct LicensePlate: Identifiable, Codable, Hashable {
    enum Region: String, Codable, CaseIterable, Identifiable {
        case northAmerica = "North America"
        case europe = "Europe"
        var id: String { rawValue }
    }

    enum Country: String, Codable, CaseIterable, Identifiable {
        case usa = "United States"
        case canada = "Canada"
        case uk = "United Kingdom"
        var id: String { rawValue }
    }

    enum State: String, Codable, CaseIterable, Identifiable {
        // subset for demo
        case california = "California"
        case texas = "Texas"
        case newYork = "New York"
        case ontario = "Ontario"
        case quebec = "Quebec"
        case england = "England"
        var id: String { rawValue }
    }

    let id: UUID
    let region: Region
    let country: Country
    let state: State

    init(region: Region, country: Country, state: State) {
        self.id = UUID()
        self.region = region
        self.country = country
        self.state = state
    }

    var displayName: String {
        return state.rawValue
    }
}

struct PlateRecord: Identifiable, Codable, Hashable {
    let plate: LicensePlate
    var foundDate: Date? = nil
    var id: UUID { plate.id }
}
