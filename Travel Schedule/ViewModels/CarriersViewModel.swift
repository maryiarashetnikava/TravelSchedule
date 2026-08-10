import Observation

@MainActor
@Observable
final class CarriersViewModel {
    
    private let networkClient = NetworkClient.shared
    
    var carriers: [CarrierOption] = []
    var errorState: ErrorState?
    var isLoading = false
    
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
    
    
    func loadRoutes(
        from: String,
        to: String,
        departureStationCode: String,
        destinationStationCode: String
    ) async {
        isLoading = true

        do {
            carriers = []

            let response = try await networkClient.searchRoutes(
                from: from,
                to: to
            )
            
            let segments = response.segments ?? []
            
            let filteredSegments = segments.filter {
                $0.from?.code == departureStationCode &&
                $0.to?.code == destinationStationCode
            }
            
            
            let sortedSegments = filteredSegments.sorted {
                if $0.start_date != $1.start_date {
                    return ($0.start_date ?? "") < ($1.start_date ?? "")
                }

                return ($0.departure ?? "") < ($1.departure ?? "")
            }

            carriers = sortedSegments.map(CarrierOption.init)

            isLoading = false

        } catch {
            errorState = error.errorState
            isLoading = false
        }
    }
}
