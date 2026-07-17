enum DepartureTimeOption: CaseIterable, Identifiable {
    case morning
    case day
    case evening
    case night

    var id: Self { self }

    var title: String {
        switch self {
        case .morning:
            return "Утро 06:00 - 12:00"
        case .day:
            return "День 12:00 - 18:00"
        case .evening:
            return "Вечер 18:00 - 00:00"
        case .night:
            return "Ночь 00:00 - 06:00"
        }
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
