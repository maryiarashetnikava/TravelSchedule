enum ErrorState {
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
