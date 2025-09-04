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
        // US States
        case alabama = "Alabama"
        case alaska = "Alaska"
        case arizona = "Arizona"
        case arkansas = "Arkansas"
        case california = "California"
        case colorado = "Colorado"
        case connecticut = "Connecticut"
        case delaware = "Delaware"
        case florida = "Florida"
        case georgia = "Georgia"
        case hawaii = "Hawaii"
        case idaho = "Idaho"
        case illinois = "Illinois"
        case indiana = "Indiana"
        case iowa = "Iowa"
        case kansas = "Kansas"
        case kentucky = "Kentucky"
        case louisiana = "Louisiana"
        case maine = "Maine"
        case maryland = "Maryland"
        case massachusetts = "Massachusetts"
        case michigan = "Michigan"
        case minnesota = "Minnesota"
        case mississippi = "Mississippi"
        case missouri = "Missouri"
        case montana = "Montana"
        case nebraska = "Nebraska"
        case nevada = "Nevada"
        case newHampshire = "New Hampshire"
        case newJersey = "New Jersey"
        case newMexico = "New Mexico"
        case newYork = "New York"
        case northCarolina = "North Carolina"
        case northDakota = "North Dakota"
        case ohio = "Ohio"
        case oklahoma = "Oklahoma"
        case oregon = "Oregon"
        case pennsylvania = "Pennsylvania"
        case rhodeIsland = "Rhode Island"
        case southCarolina = "South Carolina"
        case southDakota = "South Dakota"
        case tennessee = "Tennessee"
        case texas = "Texas"
        case utah = "Utah"
        case vermont = "Vermont"
        case virginia = "Virginia"
        case washington = "Washington"
        case westVirginia = "West Virginia"
        case wisconsin = "Wisconsin"
        case wyoming = "Wyoming"
        // Canadian Provinces and Territories
        case alberta = "Alberta"
        case britishColumbia = "British Columbia"
        case manitoba = "Manitoba"
        case newBrunswick = "New Brunswick"
        case newfoundlandAndLabrador = "Newfoundland and Labrador"
        case novaScotia = "Nova Scotia"
        case ontario = "Ontario"
        case princeEdwardIsland = "Prince Edward Island"
        case quebec = "Quebec"
        case saskatchewan = "Saskatchewan"
        case northwestTerritories = "Northwest Territories"
        case nunavut = "Nunavut"
        case yukon = "Yukon"
        // UK (existing)
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
