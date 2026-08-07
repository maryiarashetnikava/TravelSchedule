import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel = CarrierInfoViewModel()

    let carrierCode: String
    
    var body: some View {
        VStack(alignment: .center) {

            if let logoURL = viewModel.carrier?.logo,
               let url = URL(string: logoURL) {

                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.top, 16)

            } else {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.ypLightGray)
                    .frame(height: 104)
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.ypGray)
                    }
                    .padding(.top, 16)
            }

            VStack(alignment: .leading, spacing: 24) {

                Text(viewModel.carrier?.title ?? "Неизвестный перевозчик")
                    .font(.system(size: 24, weight: .bold))

                VStack(alignment: .leading, spacing: 4) {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlack)

                    Text(viewModel.email)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.ypBlue)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlack)

                    Text(viewModel.phone)
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
        .task {
            await viewModel.loadCarrier(code: carrierCode)
        }
    }
}


#Preview {
    NavigationStack {
        CarrierInfoView(carrierCode: "112")
    }
}
