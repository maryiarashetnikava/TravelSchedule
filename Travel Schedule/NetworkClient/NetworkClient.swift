import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

actor NetworkClient {
    
    static let shared = NetworkClient()

    private let client: Client

    private let searchService: SearchService
    private let scheduleService: ScheduleService
    private let carrierService: CarrierService
    private let stationsListService: StationsListService
    private let nearestStationsService: NearestStationsService
    private let nearestSettlementService: NearestSettlementService
    private let threadService: ThreadService
    private let copyrightService: CopyrightService

    private init() {
        let transport = URLSessionTransport()

        client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: transport
        )

        let apiKey = APIConfig.apiKey

        searchService = SearchService(
            client: client,
            apikey: apiKey
        )

        scheduleService = ScheduleService(
            client: client,
            apikey: apiKey
        )

        carrierService = CarrierService(
            client: client,
            apikey: apiKey
        )

        stationsListService = StationsListService(
            client: client,
            apikey: apiKey
        )

        nearestStationsService = NearestStationsService(
            client: client,
            apikey: apiKey
        )

        nearestSettlementService = NearestSettlementService(
            client: client,
            apikey: apiKey
        )

        threadService = ThreadService(
            client: client,
            apikey: apiKey
        )

        copyrightService = CopyrightService(
            client: client,
            apikey: apiKey
        )
    }
    
    func searchRoutes(from: String,to: String) async throws -> SearchResponse {
        try await searchService.getSchedualBetweenStations(
            from: from,
            to: to
        )
    }
    
    func getStationSchedule(station: String) async throws -> ScheduleResponse {
        try await scheduleService.getStationSchedule(station: station)
    }
    
    func getCarrierInfo(code: String) async throws -> CarrierResponse {
        try await carrierService.getCarrierInfo(
            code: code
        )
    }

    func getNearestStations(lat: Double,lng: Double,distance: Int) async throws -> NearestStations {
        try await nearestStationsService.getNearestStations(
            lat: lat,
            lng: lng,
            distance: distance
        )
    }

    func getNearestCity(lat: Double,lng: Double) async throws -> NearestSettlement {
        try await nearestSettlementService.getNearestCity(
            lat: lat,
            lng: lng
        )
    }

    func getAllStations() async throws -> StationsListResponse {
        try await stationsListService.getAllStations()
    }

    func getRouteStations(uid: String) async throws -> ThreadResponse {
        try await threadService.getRouteStations(
            uid: uid
        )
    }

    func getCopyright() async throws -> CopyrightResponse {
        try await copyrightService.getCopyright()
    }
    
}
