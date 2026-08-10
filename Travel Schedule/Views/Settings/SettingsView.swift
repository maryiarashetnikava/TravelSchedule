import SwiftUI

struct SettingsView: View {

    @State private var viewModel = SettingsViewModel()

    var body: some View {
        VStack(spacing: 0) {

            Toggle(isOn: $viewModel.isDarkTheme) {
                Text("Темная тема")
                    .font(.system(size: 17))
                    .foregroundStyle(.ypBlack)
            }
            .tint(.ypBlue)
            .padding(.vertical, 19)

            Button {
                viewModel.showUserAgreement()
            } label: {
                HStack {
                    Text("Пользовательское соглашение")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlack)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.ypBlack)
                }
                .padding(.vertical, 19)
            }

            Spacer()

            VStack(spacing: 16) {
                Text(viewModel.apiInfo)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlack)
                    .multilineTextAlignment(.center)

                Text(viewModel.appVersion)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlack)
            }
            .padding(.bottom, 24)
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ypBackground)
        .fullScreenCover(
            isPresented: $viewModel.isUserAgreementPresented
        ) {
            NavigationStack {
                UserAgreementView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}


