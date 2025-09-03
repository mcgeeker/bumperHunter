import SwiftUI

struct NewTripView: View {
    @EnvironmentObject var store: TripStore
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date().addingTimeInterval(86400)
    @State private var selectedPlates: Set<LicensePlate> = []

    var body: some View {
        Form {
            Section(header: Text("Trip")) {
                TextField("Name", text: $name)
                DatePicker("Start", selection: $startDate, displayedComponents: .date)
                DatePicker("End", selection: $endDate, displayedComponents: .date)
            }
            Section(header: Text("Plates")) {
                plateSelection
            }
        }
        .navigationTitle("New Trip")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Start") {
                    store.startNewTrip(name: name, startDate: startDate, endDate: endDate, plates: Array(selectedPlates))
                    dismiss()
                }.disabled(name.isEmpty || selectedPlates.isEmpty)
            }
        }
    }

    var plateSelection: some View {
        List {
            ForEach(LicensePlateLibrary.regions) { region in
                DisclosureGroup(region.rawValue) {
                    MultipleSelectionRow(title: "All \(region.rawValue)", isSelected: isRegionSelected(region)) {
                        toggleRegion(region)
                    }
                    let countries = LicensePlateLibrary.countries(in: region)
                    ForEach(countries) { country in
                        DisclosureGroup(country.rawValue) {
                            MultipleSelectionRow(title: "All \(country.rawValue)", isSelected: isCountrySelected(region: region, country: country)) {
                                toggleCountry(region: region, country: country)
                            }
                            let states = LicensePlateLibrary.states(in: country)
                            ForEach(states, id: \.self) { state in
                                let plate = LicensePlate(region: region, country: country, state: state)
                                MultipleSelectionRow(title: state.rawValue, isSelected: selectedPlates.contains(plate)) {
                                    toggleState(plate)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func isRegionSelected(_ region: LicensePlate.Region) -> Bool {
        let plates = LicensePlateLibrary.plates(for: region)
        return Set(plates).isSubset(of: selectedPlates)
    }

    private func toggleRegion(_ region: LicensePlate.Region) {
        let plates = LicensePlateLibrary.plates(for: region)
        if isRegionSelected(region) {
            selectedPlates.subtract(plates)
        } else {
            selectedPlates.formUnion(plates)
        }
    }

    private func isCountrySelected(region: LicensePlate.Region, country: LicensePlate.Country) -> Bool {
        let plates = LicensePlateLibrary.plates(for: region, country: country)
        return Set(plates).isSubset(of: selectedPlates)
    }

    private func toggleCountry(region: LicensePlate.Region, country: LicensePlate.Country) {
        let plates = LicensePlateLibrary.plates(for: region, country: country)
        if isCountrySelected(region: region, country: country) {
            selectedPlates.subtract(plates)
        } else {
            selectedPlates.formUnion(plates)
        }
    }

    private func toggleState(_ plate: LicensePlate) {
        if selectedPlates.contains(plate) {
            selectedPlates.remove(plate)
        } else {
            selectedPlates.insert(plate)
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
        .foregroundColor(.primary)
    }
}
