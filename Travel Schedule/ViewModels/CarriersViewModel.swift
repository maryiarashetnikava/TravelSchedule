import Observation

@Observable
final class CarriersViewModel {
    private let carriers = [
        CarrierOption(
            carrierName: "РЖД",
            logoName: "rzdLogo",
            transferInfo: "С пересадкой в Костроме",
            date: "14 января",
            departureTime: "22:30",
            duration: "20 часов",
            arrivalTime: "08:15"
        ),
        CarrierOption(
            carrierName: "ФГК",
            logoName: "fgkLogo",
            transferInfo: nil,
            date: "15 января",
            departureTime: "01:15",
            duration: "9 часов",
            arrivalTime: "09:00"
        ),
        CarrierOption(
            carrierName: "Урал логистика",
            logoName: "uralLogo",
            transferInfo: nil,
            date: "16 января",
            departureTime: "12:30",
            duration: "9 часов",
            arrivalTime: "21:00"
        ),
        CarrierOption(
            carrierName: "РЖД",
            logoName: "rzdLogo",
            transferInfo: "С пересадкой в Костроме",
            date: "17 января",
            departureTime: "22:30",
            duration: "20 часов",
            arrivalTime: "08:15"
        ),
        CarrierOption(
            carrierName: "РЖД",
            logoName: "rzdLogo",
            transferInfo: "С пересадкой в Костроме",
            date: "17 января",
            departureTime: "22:30",
            duration: "20 часов",
            arrivalTime: "08:15"
        )
    ]
    
    var selectedTimes: Set<DepartureTimeOption> = []
    var transfersAllowed: Bool?
    var isFilterApplied = false
    
    var hasSelectedFilters: Bool {
        !selectedTimes.isEmpty || transfersAllowed != nil
    }
    
    var filteredCarriers: [CarrierOption] {
        guard isFilterApplied else {
            return carriers
        }

        return carriers.filter(matchesFilters)
    }
    
    private func matchesFilters(_ carrier: CarrierOption) -> Bool {
        let matchesTime: Bool

        if selectedTimes.isEmpty {
            matchesTime = true
        } else if let departureHour = carrier.departureHour {
            matchesTime = selectedTimes.contains { option in
                option.contains(hour: departureHour)
            }
        } else {
            matchesTime = false
        }

        let matchesTransfers: Bool

        if let transfersAllowed {
            matchesTransfers = transfersAllowed || !carrier.hasTransfer
        } else {
            matchesTransfers = true
        }

        return matchesTime && matchesTransfers
    }
    
    func toggleTime(_ option: DepartureTimeOption) {
        if selectedTimes.contains(option) {
            selectedTimes.remove(option)
        } else {
            selectedTimes.insert(option)
        }
    }

    func selectTransfers(_ value: Bool) {
        transfersAllowed = value
    }

    func applyFilters() {
        isFilterApplied = true
    }
}
