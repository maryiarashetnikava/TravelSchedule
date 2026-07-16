import SwiftUI

struct CarriersView: View {
    @Environment(\.dismiss) private var dismiss
    
    let departure: String
    let destination: String

    @State private var viewModel = CarriersViewModel()

    var body: some View {
        VStack(spacing: 0) {
            Text("\(departure) → \(destination)")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 24)

            if viewModel.filteredCarriers.isEmpty {
                Spacer()

                Text("Вариантов нет")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)

                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.filteredCarriers) { carrier in
                            NavigationLink {
                                CarrierInfoView()
                            } label: {
                                VStack(spacing: 0) {
                                    HStack(alignment: .center, spacing: 12) {
                                        Image(carrier.logoName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 44, height: 44)

                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(carrier.carrierName)
                                                .font(.system(size: 20))
                                                .foregroundStyle(.ypBlackUniversal)

                                            if let transferInfo = carrier.transferInfo {
                                                Text(transferInfo)
                                                    .font(.system(size: 14))
                                                    .foregroundStyle(.ypRed)
                                            }
                                        }

                                        Spacer()

                                        Text(carrier.date)
                                            .font(.system(size: 14))
                                            .foregroundStyle(.ypBlackUniversal)
                                    }

                                    Spacer()

                                    HStack(spacing: 8) {
                                        Text(carrier.departureTime)
                                            .font(.system(size: 20))
                                            .foregroundStyle(.ypBlackUniversal)

                                        Rectangle()
                                            .fill(.ypGray)
                                            .frame(height: 1)

                                        Text(carrier.duration)
                                            .font(.system(size: 14))
                                            .foregroundStyle(.ypBlackUniversal)
                                            .fixedSize()

                                        Rectangle()
                                            .fill(.ypGray)
                                            .frame(height: 1)

                                        Text(carrier.arrivalTime)
                                            .font(.system(size: 20))
                                            .foregroundStyle(.ypBlackUniversal)
                                    }
                                }
                                .padding(14)
                                .frame(height: 120)
                                .background(.ypLightGray)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 84)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            
            NavigationLink {
                FiltersView(viewModel: viewModel)
            } label: {
                HStack(spacing: 4) {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))

                    if viewModel.isFilterApplied {
                        Circle()
                            .fill(.ypRed)
                            .frame(width: 6, height: 6)
                    }
                }
                .foregroundStyle(.ypWhiteUniversal)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(.ypBlue)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
        }
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
        .toolbar(.hidden, for: .tabBar)
        .background(.ypBackground)
    }
}

#Preview {
    NavigationStack {
        CarriersView(
            departure: "Москва (Ярославский вокзал)",
            destination: "Санкт Петербург (Балтийский вокзал)"
        )
    }
}
