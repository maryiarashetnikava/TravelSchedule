import Observation
import SwiftUI

@MainActor
@Observable
final class SettingsViewModel {

    var isDarkTheme: Bool {
        didSet {
            UserDefaults.standard.set(isDarkTheme, forKey: "isDarkTheme")
        }
    }

    var isUserAgreementPresented = false

    let appVersion = "Версия 1.0 (beta)"
    let apiInfo = "Приложение использует API «Яндекс.Расписания»"

    init() {
        isDarkTheme = UserDefaults.standard.bool(forKey: "isDarkTheme")
    }

    func showUserAgreement() {
        isUserAgreementPresented = true
    }

    func hideUserAgreement() {
        isUserAgreementPresented = false
    }
}
