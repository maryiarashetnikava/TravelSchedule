import Foundation

struct City: Identifiable, Sendable {
    let id: String
    let title: String
    let stations: [Station]
}


