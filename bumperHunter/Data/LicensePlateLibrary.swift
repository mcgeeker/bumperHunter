import Foundation

struct LicensePlateLibrary {
    static let allPlates: [LicensePlate] = [
        LicensePlate(region: .northAmerica, country: .usa, state: .california),
        LicensePlate(region: .northAmerica, country: .usa, state: .texas),
        LicensePlate(region: .northAmerica, country: .usa, state: .newYork),
        LicensePlate(region: .northAmerica, country: .canada, state: .ontario),
        LicensePlate(region: .northAmerica, country: .canada, state: .quebec),
        LicensePlate(region: .europe, country: .uk, state: .england)
    ]

    static func plates(for region: LicensePlate.Region? = nil,
                       country: LicensePlate.Country? = nil) -> [LicensePlate] {
        allPlates.filter { plate in
            (region == nil || plate.region == region!) &&
            (country == nil || plate.country == country!)
        }
    }

    static var regions: [LicensePlate.Region] {
        Array(Set(allPlates.map { $0.region })).sorted { $0.rawValue < $1.rawValue }
    }

    static func countries(in region: LicensePlate.Region) -> [LicensePlate.Country] {
        Array(Set(allPlates.filter { $0.region == region }.map { $0.country })).sorted { $0.rawValue < $1.rawValue }
    }

    static func states(in country: LicensePlate.Country) -> [LicensePlate.State] {
        Array(Set(allPlates.filter { $0.country == country }.map { $0.state })).sorted { $0.rawValue < $1.rawValue }
    }
}
