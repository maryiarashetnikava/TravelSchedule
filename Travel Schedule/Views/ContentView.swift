import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testFetchStations()
            testFetchCopyright()
            testFetchSearch()
            testFetchSchedule()
            testFetchThread()
            testFetchNearestSettlement()
            testFetchCarrier()
            testFetchStationsList()
        }
    }
}

#Preview {
    ContentView()
}

// Функции для тестового вызова API
func testFetchStations() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                
                transport: URLSessionTransport()
            )
            
            let service = NearestStationsService(
                client: client,
                apikey: APIConfig.apiKey
            )
            
            print("Fetching stations...")
            let stations = try await service.getNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50
            )
            
            print("Successfully fetched stations: \(stations)")
            
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
}

func testFetchCopyright() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = CopyrightService(
                client: client,
                apikey: APIConfig.apiKey
            )
            
            print("Fetching copyright...")
            
            let copyright = try await service.getCopyright()
            
            print("Successfully fetched copyright:")
            print(copyright)
            
        } catch {
            print("Error fetching copyright: \(error)")
        }
    }
    
}

func testFetchSearch() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = SearchService(
                client: client,
                apikey: APIConfig.apiKey
            )
            
            print("Fetching search...")
            
            let response = try await service.getSchedualBetweenStations(
                from: "s9600396",
                to: "s9812964"
            )
            
            print("Successfully fetched search:")
            print(response)
            
        } catch {
            print("Search error: \(error)")
        }
    }
}

func testFetchSchedule() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = ScheduleService(
                client: client,
                apikey: APIConfig.apiKey
            )
            
            print("Fetching schedule...")
            
            let schedule = try await service.getStationSchedule(
                station: "s9812964"
            )
            
            print("Successfully fetched schedule:")
            print(schedule)
            
        } catch {
            print("Schedule error: \(error)")
        }
    }
}

func testFetchThread() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = ThreadService(
                client: client,
                apikey: APIConfig.apiKey
            )
            
            print("Fetching thread...")
            
            let thread = try await service.getRouteStations(
                uid: "SU-1827A_c26_agent"
            )
            
            print("Successfully fetched thread:")
            print(thread)
            
        } catch {
            print("Thread error: \(error)")
        }
    }
}

func testFetchNearestSettlement() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = NearestSettlementService(
                client: client,
                apikey: APIConfig.apiKey
            )
            
            print("Fetching nearest settlement...")
            
            let settlement = try await service.getNearestCity(
                lat: 59.864177,
                lng: 30.319163
            )
            
            print("Successfully fetched nearest settlement:")
            print(settlement)
            
        } catch {
            print("Nearest settlement error: \(error)")
        }
    }
}

func testFetchCarrier() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = CarrierService(
                client: client,
                apikey: APIConfig.apiKey
            )
            
            print("Fetching carrier...")
            
            let carrier = try await service.getCarrierInfo(
                code: "196"
            )
            
            print("Successfully fetched carrier:")
            print(carrier)
            
        } catch {
            print("Carrier error: \(error)")
        }
    }
}

func testFetchStationsList() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = StationsListService(
                client: client,
                apikey: APIConfig.apiKey
            )
            
            print("Fetching stations list...")
            
            let stations = try await service.getAllStations()
            
            print("Successfully fetched stations list:")
            print(stations)
            
        } catch {
            print("Stations list error: \(error)")
        }
    }
}
