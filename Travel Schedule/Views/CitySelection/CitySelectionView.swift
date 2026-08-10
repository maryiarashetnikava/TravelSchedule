import SwiftUI

struct CitySelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = CitySelectionViewModel()
    
    let onStationSelected: (String, String, String, String) -> Void
    
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
                .background(.ypSearchBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 16)
                
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.ypBlack)
                    
                    Spacer()
                } else if viewModel.filteredCities.isEmpty {
                    Text("Город не найден")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.ypBlack)
                    
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.filteredCities) { city in
                                NavigationLink {
                                    StationSelectionView(city: city) { station in
                                        onStationSelected(
                                            city.title,
                                            station.title,
                                            station.cityCode,
                                            station.id
                                        )
                                        dismiss()
                                    }
                                } label: {
                                    HStack {
                                        Text(city.title)
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
            .background(.ypBackground)
            .task {
                await viewModel.loadCities()
            }
        }
    }
}

#Preview {
    CitySelectionView { _, _, _, _ in }
}
