import Foundation

enum ErrorState: Sendable {
    case serverError
    case noInternet

    var imageName: String {
        switch self {
        case .serverError:
            return "ServerError"
        case .noInternet:
            return "NoInternet"
        }
    }

    var message: String {
        switch self {
        case .serverError:
            return "Ошибка сервера"
        case .noInternet:
            return "Нет интернета"
        }
    }
}

extension Error {

    var errorState: ErrorState {
        guard let urlError = self as? URLError else {
            return .serverError
        }

        switch urlError.code {
        case .notConnectedToInternet:
            return .noInternet
        default:
            return .serverError
        }
    }
}
