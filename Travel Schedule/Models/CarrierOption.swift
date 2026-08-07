import Foundation

struct CarrierOption: Identifiable, Sendable {
    let id = UUID()
    let code: String
    let carrierName: String
    let logoURL: String?
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

extension CarrierOption {

    init(segment: Components.Schemas.Segment) {
        self.code = String(segment.thread?.carrier?.code ?? 0)
        self.carrierName = segment.thread?.carrier?.title ?? "Неизвестный перевозчик"
        self.logoURL = segment.thread?.carrier?.logo
        self.transferInfo = segment.has_transfers == true ? "С пересадкой" : nil
        self.departureTime = segment.departure?.formattedTime() ?? ""
        self.arrivalTime = segment.arrival?.formattedTime() ?? ""
        self.date = segment.start_date?.formattedDate() ?? ""
        self.duration = segment.duration?.formattedDuration() ?? ""    }
}
