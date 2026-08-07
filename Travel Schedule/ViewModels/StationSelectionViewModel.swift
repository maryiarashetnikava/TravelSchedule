import Observation
import Foundation

@MainActor
@Observable
final class StationSelectionViewModel {
    var searchText = ""

    var stations: [Station] = []
    
    var filteredStations: [Station] {
        guard !searchText.isEmpty else {
            return stations
        }

        return stations.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
}
