import Foundation

extension String {

    func formattedTime() -> String {
        String(prefix(5))
    }

    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let date = formatter.date(from: self) else {
            return self
        }

        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"

        return formatter.string(from: date)
    }
}

extension Date {

    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }

    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: self)
    }
}

extension Int {

    func formattedDuration() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60

        if minutes == 0 {
            return "\(hours) ч"
        }

        return "\(hours) ч \(minutes) мин"
    }
}


