import SwiftUI

struct StationSelectionView: View {
    let city: String
    let onStationSelected: (String) -> Void

    @State private var viewModel = StationSelectionViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.ypBlack)

                TextField(
                    "Введите запрос",
                    text: $viewModel.searchText
                )
                .foregroundStyle(.ypBlack)
            }
            .padding(.horizontal, 16)
            .frame(height: 36)
            .background(.ypLightGray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 16)

            Spacer()

            if viewModel.filteredStations.isEmpty {
                Text("Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)

                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.filteredStations, id: \.self) { station in
                            Button {
                                onStationSelected(station)
                            } label: {
                                HStack {
                                    Text(station)
                                        .foregroundStyle(.ypBlack)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.ypBlack)
                                }
                                .frame(height: 60)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        StationSelectionView(city: "Москва") { _ in }
    }
}
