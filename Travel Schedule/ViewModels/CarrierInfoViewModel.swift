import Observation

@MainActor
@Observable
final class CarrierInfoViewModel {

    private let networkClient = NetworkClient.shared

    var carrier: Components.Schemas.Carrier?
    var isLoading = false
    var errorState: ErrorState?
    
    var email: String {
        guard let email = carrier?.email,
              !email.isEmpty else {
            return "Не указано"
        }

        return email
    }

    var phone: String {
        guard let phone = carrier?.phone,
              !phone.isEmpty else {
            return "Не указано"
        }

        return phone
    }

    func loadCarrier(code: String) async {
        isLoading = true

        do {
            let response = try await networkClient.getCarrierInfo(code: code)
            carrier = response.carrier
        } catch {
            errorState = error.errorState
        }

        isLoading = false
    }
}
