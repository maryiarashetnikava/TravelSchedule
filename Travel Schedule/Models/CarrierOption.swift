import Foundation

struct CarrierOption: Identifiable {
    let id = UUID()
    let carrierName: String
    let logoName: String
    let transferInfo: String?
    let date: String
    let departureTime: String
    let duration: String
    let arrivalTime: String
    
    var hasTransfer: Bool {
        transferInfo != nil
    }
    
    var departureHour: Int? {
        let hour = departureTime.split(separator: ":").first

        guard let hour else {
            return nil
        }

        return Int(hour)
    }
}
