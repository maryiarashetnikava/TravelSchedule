import Observation
import Foundation

@MainActor
@Observable
final class CitySelectionViewModel {
    
    private let networkClient = NetworkClient.shared

    var cities: [City] = []
    var searchText = ""
    var errorState: ErrorState?
    var isLoading = false
    
    var filteredCities: [City] {
        guard !searchText.isEmpty else {
            return cities
        }

        return cities.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func loadCities() async {
        isLoading = true

        do {
            let response = try await networkClient.getAllStations()

            var cities: [City] = []

            for country in response.countries ?? [] {
                for region in country.regions ?? [] {
                    for settlement in region.settlements ?? [] {
                        
                        let city = City(
                            id: settlement.codes?.yandex_code ?? UUID().uuidString,
                            title: settlement.title ?? "",
                            stations: (settlement.stations ?? []).map {
                                Station(
                                    id: $0.codes?.yandex_code ?? "",
                                    cityCode: settlement.codes?.yandex_code ?? "",
                                    title: $0.title ?? ""
                                )
                            }
                        )

                        cities.append(city)
                    }
                }
            }

            self.cities = cities
        } catch {
            errorState = error.errorState
        }

        isLoading = false
    }
}
