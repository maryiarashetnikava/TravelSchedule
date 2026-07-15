import SwiftUI

struct MainView: View {
    @State private var viewModel = MainViewModel()
    @State private var selectionType: RouteSelectionType?
    
    var body: some View {
        Group {
            if let errorState = viewModel.errorState {
                ErrorView(state: errorState)
            } else {
                VStack {
                    Spacer()
                        .frame(height: 218)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Button {
                                selectionType = .departure
                            } label: {
                                Text(viewModel.departure.isEmpty ? "Откуда" : viewModel.departure)
                                    .foregroundStyle(
                                        viewModel.departure.isEmpty ? .ypGray : .ypBlackUniversal                                    )
                            }
                            
                            Spacer()
                            
                            Button {
                                selectionType = .destination
                            } label: {
                                Text(viewModel.destination.isEmpty ? "Куда" : viewModel.destination)
                                    .foregroundStyle(
                                        viewModel.destination.isEmpty ? .ypGray : .ypBlackUniversal
                                    )
                            }
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 96)
                        .background(.ypWhiteUniversal)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Button {
                            viewModel.swapRoute()
                        } label: {
                            Image(systemName: "arrow.2.squarepath")
                                .foregroundStyle(.ypBlue)
                                .frame(width: 36, height: 36)
                                .background(.ypWhiteUniversal)
                                .clipShape(Circle())
                        }
                    }
                    .padding(16)
                    .frame(height: 128)
                    .background(.ypBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    if viewModel.isSearchButtonVisible {
                        NavigationLink {
                            CarriersView(
                                departure: viewModel.departure,
                                destination: viewModel.destination
                            )
                        } label: {
                            Text("Найти")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(.ypWhiteUniversal)
                                .frame(width: 150, height: 60)
                                .background(.ypBlue)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.top, 16)
                    }
                    
                    Spacer()
                }
                
                .padding(.horizontal, 16)
            }
        }
        .fullScreenCover(item: $selectionType) { selectionType in
            CitySelectionView { city, station in
                viewModel.selectRoute(
                    city: city,
                    station: station,
                    for: selectionType
                )
            }
        }
        
    }

}



#Preview {
    MainView()
}
