import SwiftUI

struct UserAgreementView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        UserAgreementWebView()
            .background(.ypBackground)
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Пользовательское соглашение")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.ypBlack)
                    }
                }
            }
    }
}
#Preview {
    NavigationStack {
        UserAgreementView()
    }
}
