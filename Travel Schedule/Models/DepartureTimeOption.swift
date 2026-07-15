import Foundation

enum DepartureTimeOption: String, CaseIterable, Identifiable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
    
    var id: Self {
        self
    }
    
    func contains(hour: Int) -> Bool {
        switch self {
        case .morning:
            return hour >= 6 && hour < 12
        case .day:
            return hour >= 12 && hour < 18
        case .evening:
            return hour >= 18 && hour < 24
        case .night:
            return hour >= 0 && hour < 6
        }
    }
}
