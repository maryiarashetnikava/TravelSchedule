import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                MainView()
            }
            .tabItem {
                Image(systemName: "arrow.up.message.fill")
            }

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
            }
        }
        .tint(.ypBlack)
    }
}

#Preview {
    MainTabView()
}
