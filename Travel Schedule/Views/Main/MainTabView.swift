import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "arrow.up.message.fill")
                }

            SettingsView()
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
