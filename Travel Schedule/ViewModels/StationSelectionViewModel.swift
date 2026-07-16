import Observation
import Foundation

@Observable
final class StationSelectionViewModel {
    var searchText = ""

    private let stations = [
        "Киевский вокзал",
        "Курский вокзал",
        "Ярославский вокзал",
        "Белорусский вокзал",
        "Савеловский вокзал",
        "Ленинградский вокзал"
    ]

    var filteredStations: [String] {
        guard !searchText.isEmpty else {
            return stations
        }

        return stations.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
}
