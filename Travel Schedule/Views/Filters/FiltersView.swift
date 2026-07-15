
import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss

    let viewModel: CarriersViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
                .padding(.top, 24)
                .padding(.bottom, 16)

            ForEach(DepartureTimeOption.allCases) { option in
                Button {
                    viewModel.toggleTime(option)
                } label: {
                    HStack {
                        Text(option.rawValue)
                            .font(.system(size: 17))
                            .foregroundStyle(.ypBlack)

                        Spacer()

                        Image(
                            systemName: viewModel.selectedTimes.contains(option)
                                ? "checkmark.square.fill"
                                : "square"
                        )
                        .font(.system(size: 20))
                        .foregroundStyle(.ypBlack)
                    }
                    .frame(height: 60)
                }
            }

            Text("Показывать варианты с\nпересадками")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
                .padding(.top, 16)
                .padding(.bottom, 16)

            Button {
                viewModel.selectTransfers(true)
            } label: {
                HStack {
                    Text("Да")
                        .font(.system(size: 17))
                        .foregroundStyle(.ypBlack)

                    Spacer()

                    Image(
                        systemName: viewModel.transfersAllowed == true
                            ? "largecircle.fill.circle"
                            : "circle"
                    )
                    .font(.system(size: 20))
                    .foregroundStyle(.ypBlack)
                }
                .frame(height: 60)
            }

            Button {
                viewModel.selectTransfers(false)
            } label: {
                HStack {
                    Text("Нет")
                        .font(.system(size: 17))
                        .foregroundStyle(.ypBlack)

                    Spacer()

                    Image(
                        systemName: viewModel.transfersAllowed == false
                            ? "largecircle.fill.circle"
                            : "circle"
                    )
                    .font(.system(size: 20))
                    .foregroundStyle(.ypBlack)
                }
                .frame(height: 60)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .safeAreaInset(edge: .bottom) {
            if viewModel.hasSelectedFilters {
                Button {
                    viewModel.applyFilters()
                    dismiss()
                } label: {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.ypWhiteUniversal)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(.ypBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
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
    }
}

#Preview {
    FiltersView(viewModel: CarriersViewModel())
}
