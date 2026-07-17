import SwiftUI

struct ContentView: View {
    @State private var isSplashVisible = true

    var body: some View {
        if isSplashVisible {
            SplashView()
                .task {
                    try? await Task.sleep(for: .seconds(1))
                    isSplashVisible = false
                }
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}

