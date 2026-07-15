import SwiftUI

struct ErrorView: View {
    let state: ErrorState

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(state.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)

            Text(state.message)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview("Server Error") {
    ErrorView(state: .serverError)
}

#Preview("No Internet") {
    ErrorView(state: .noInternet)
}
