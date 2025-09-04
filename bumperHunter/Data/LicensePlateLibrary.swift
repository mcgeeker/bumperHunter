import Foundation

struct LicensePlateLibrary {
    static let allPlates: [LicensePlate] = [
        // United States
        LicensePlate(region: .northAmerica, country: .usa, state: .alabama),
        LicensePlate(region: .northAmerica, country: .usa, state: .alaska),
        LicensePlate(region: .northAmerica, country: .usa, state: .arizona),
        LicensePlate(region: .northAmerica, country: .usa, state: .arkansas),
        LicensePlate(region: .northAmerica, country: .usa, state: .california),
        LicensePlate(region: .northAmerica, country: .usa, state: .colorado),
        LicensePlate(region: .northAmerica, country: .usa, state: .connecticut),
        LicensePlate(region: .northAmerica, country: .usa, state: .delaware),
        LicensePlate(region: .northAmerica, country: .usa, state: .florida),
        LicensePlate(region: .northAmerica, country: .usa, state: .georgia),
        LicensePlate(region: .northAmerica, country: .usa, state: .hawaii),
        LicensePlate(region: .northAmerica, country: .usa, state: .idaho),
        LicensePlate(region: .northAmerica, country: .usa, state: .illinois),
        LicensePlate(region: .northAmerica, country: .usa, state: .indiana),
        LicensePlate(region: .northAmerica, country: .usa, state: .iowa),
        LicensePlate(region: .northAmerica, country: .usa, state: .kansas),
        LicensePlate(region: .northAmerica, country: .usa, state: .kentucky),
        LicensePlate(region: .northAmerica, country: .usa, state: .louisiana),
        LicensePlate(region: .northAmerica, country: .usa, state: .maine),
        LicensePlate(region: .northAmerica, country: .usa, state: .maryland),
        LicensePlate(region: .northAmerica, country: .usa, state: .massachusetts),
        LicensePlate(region: .northAmerica, country: .usa, state: .michigan),
        LicensePlate(region: .northAmerica, country: .usa, state: .minnesota),
        LicensePlate(region: .northAmerica, country: .usa, state: .mississippi),
        LicensePlate(region: .northAmerica, country: .usa, state: .missouri),
        LicensePlate(region: .northAmerica, country: .usa, state: .montana),
        LicensePlate(region: .northAmerica, country: .usa, state: .nebraska),
        LicensePlate(region: .northAmerica, country: .usa, state: .nevada),
        LicensePlate(region: .northAmerica, country: .usa, state: .newHampshire),
        LicensePlate(region: .northAmerica, country: .usa, state: .newJersey),
        LicensePlate(region: .northAmerica, country: .usa, state: .newMexico),
        LicensePlate(region: .northAmerica, country: .usa, state: .newYork),
        LicensePlate(region: .northAmerica, country: .usa, state: .northCarolina),
        LicensePlate(region: .northAmerica, country: .usa, state: .northDakota),
        LicensePlate(region: .northAmerica, country: .usa, state: .ohio),
        LicensePlate(region: .northAmerica, country: .usa, state: .oklahoma),
        LicensePlate(region: .northAmerica, country: .usa, state: .oregon),
        LicensePlate(region: .northAmerica, country: .usa, state: .pennsylvania),
        LicensePlate(region: .northAmerica, country: .usa, state: .rhodeIsland),
        LicensePlate(region: .northAmerica, country: .usa, state: .southCarolina),
        LicensePlate(region: .northAmerica, country: .usa, state: .southDakota),
        LicensePlate(region: .northAmerica, country: .usa, state: .tennessee),
        LicensePlate(region: .northAmerica, country: .usa, state: .texas),
        LicensePlate(region: .northAmerica, country: .usa, state: .utah),
        LicensePlate(region: .northAmerica, country: .usa, state: .vermont),
        LicensePlate(region: .northAmerica, country: .usa, state: .virginia),
        LicensePlate(region: .northAmerica, country: .usa, state: .washington),
        LicensePlate(region: .northAmerica, country: .usa, state: .westVirginia),
        LicensePlate(region: .northAmerica, country: .usa, state: .wisconsin),
        LicensePlate(region: .northAmerica, country: .usa, state: .wyoming),

        // Canada
        LicensePlate(region: .northAmerica, country: .canada, state: .alberta),
        LicensePlate(region: .northAmerica, country: .canada, state: .britishColumbia),
        LicensePlate(region: .northAmerica, country: .canada, state: .manitoba),
        LicensePlate(region: .northAmerica, country: .canada, state: .newBrunswick),
        LicensePlate(region: .northAmerica, country: .canada, state: .newfoundlandAndLabrador),
        LicensePlate(region: .northAmerica, country: .canada, state: .novaScotia),
        LicensePlate(region: .northAmerica, country: .canada, state: .ontario),
        LicensePlate(region: .northAmerica, country: .canada, state: .princeEdwardIsland),
        LicensePlate(region: .northAmerica, country: .canada, state: .quebec),
        LicensePlate(region: .northAmerica, country: .canada, state: .saskatchewan),
        LicensePlate(region: .northAmerica, country: .canada, state: .northwestTerritories),
        LicensePlate(region: .northAmerica, country: .canada, state: .nunavut),
        LicensePlate(region: .northAmerica, country: .canada, state: .yukon),

        // United Kingdom (keep existing)
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
