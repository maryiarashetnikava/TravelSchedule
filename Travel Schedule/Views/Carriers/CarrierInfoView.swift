import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) private var dismiss

    private enum Constants {
        static let carrierName = "ОАО «РЖД»"
        static let email = "info@rzd.ru"
        static let phone = "+7 (900) 000-00-00"
    }

    var body: some View {
        VStack(alignment: .center) {

            Image("rzdLargeLogo")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.top, 16)

            VStack(alignment: .leading, spacing: 24) {

                Text(Constants.carrierName)
                    .font(.system(size: 24, weight: .bold))

                VStack(alignment: .leading, spacing: 4) {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlack)

                    Text(Constants.email)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.ypBlue)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlack)

                    Text(Constants.phone)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.ypBlue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)

            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color.ypBackground)
        .navigationTitle("Информация о перевозчике")
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
        CarrierInfoView()
    }
}
