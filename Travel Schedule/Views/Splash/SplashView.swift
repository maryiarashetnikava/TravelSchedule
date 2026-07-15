import SwiftUI

struct SplashView: View {
    var body: some View {
        Image(.splashLogo)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
