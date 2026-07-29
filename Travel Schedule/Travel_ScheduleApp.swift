import SwiftUI

@main
struct Travel_ScheduleApp: App {
    @AppStorage("isDarkTheme") private var isDarkTheme = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkTheme ? .dark : .light)
        }
    }
}
