import Observation
import Foundation

@Observable
final class CitySelectionViewModel {
    var searchText = ""

    private let cities = [
        "Москва",
        "Санкт Петербург",
        "Сочи",
        "Горный воздух",
        "Краснодар",
        "Казань",
        "Омск"
    ]

    var filteredCities: [String] {
        guard !searchText.isEmpty else {
            return cities
        }

        return cities.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }
}
