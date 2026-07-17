import Observation

@Observable
final class MainViewModel {
    var departure = ""
    var destination = ""
    var errorState: ErrorState? 
    
    var isSearchButtonVisible: Bool {
        !departure.isEmpty && !destination.isEmpty
    }
    
    func swapRoute() {
        swap(&departure, &destination)
    }
    
    func selectRoute(
        city: String,
        station: String,
        for type: RouteSelectionType
    ) {
        let route = "\(city) (\(station))"
        
        switch type {
        case .departure:
            departure = route
        case .destination:
            destination = route
        }
    }
}
