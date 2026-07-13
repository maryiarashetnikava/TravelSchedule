import SwiftUI

struct CitySelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = CitySelectionViewModel()
    
    let onStationSelected: (String, String) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.ypBlack)
                    
                    TextField("Введите запрос", text: $viewModel.searchText)
                        .foregroundStyle(.ypBlack)
                }
                .padding(.horizontal, 16)
                .frame(height: 36)
                .background(.ypLightGray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 16)
                
                Spacer()
                
                if viewModel.filteredCities.isEmpty {
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.ypBlack)
                    
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.filteredCities, id: \.self) { city in
                                NavigationLink {
                                    StationSelectionView(city: city) { station in
                                        onStationSelected(city, station)
                                        dismiss()
                                    }
                                } label: {
                                    HStack {
                                        Text(city)
                                            .foregroundStyle(.ypBlack)

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.ypBlack)
                                    }
                                    .frame(height: 60)
                                    .padding(.horizontal, 16)
                                }
                            }                        }
                    }
                }
            }
            
            .navigationTitle("Выбор города")
            .navigationBarTitleDisplayMode(.inline)
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
}

#Preview {
    CitySelectionView { _, _ in }
}
