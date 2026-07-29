import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkTheme") private var isDarkTheme = false

    var body: some View {
        VStack(spacing: 0) {

            Toggle(isOn: $isDarkTheme) {
                Text("Темная тема")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.ypBlack)
            }
            .tint(.ypBlue)
            .padding(.vertical, 19)


            NavigationLink {
                UserAgreementView()
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
                Text("Приложение использует API «Яндекс.Расписания»")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlack)
                    .multilineTextAlignment(.center)

                Text("Версия 1.0 (beta)")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlack)
            }
            .padding(.bottom, 24)
        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ypBackground)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}


