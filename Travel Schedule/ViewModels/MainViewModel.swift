import Observation

@MainActor
@Observable
final class MainViewModel {
    
    var departureStation: SelectedStation?
    var destinationStation: SelectedStation?
    
    var departureCityCode: String {
        departureStation?.cityCode ?? ""
    }

    var destinationCityCode: String {
        destinationStation?.cityCode ?? ""
    }

    var departureStationCode: String {
        departureStation?.stationCode ?? ""
    }

    var destinationStationCode: String {
        destinationStation?.stationCode ?? ""
    }
    
    var departure: String {
        guard let departureStation else {
            return ""
        }

        return "\(departureStation.city) (\(departureStation.station))"
    }

    var destination: String {
        guard let destinationStation else {
            return ""
        }

        return "\(destinationStation.city) (\(destinationStation.station))"
    }
    
    var errorState: ErrorState?
    
    var isSearchButtonVisible: Bool {
        departureStation != nil && destinationStation != nil
    }
    
    func swapRoute() {
        swap(&departureStation, &destinationStation)
    }
    
    func selectRoute(
        city: String,
        station: String,
        cityCode: String,
        stationCode: String,
        for type: RouteSelectionType
    ) {
        
        let selectedStation = SelectedStation(
            city: city,
            cityCode: cityCode,
            station: station,
            stationCode: stationCode
        )
        
        switch type {
        case .departure:
            departureStation = selectedStation

        case .destination:
            destinationStation = selectedStation
        }
    }
}
