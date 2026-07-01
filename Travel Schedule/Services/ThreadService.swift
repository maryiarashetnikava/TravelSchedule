import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadResponse = Components.Schemas.ThreadStationsResponse

protocol ThreadServiceProtocol {
    func getRouteStations(uid: String) async throws -> ThreadResponse
}

final class ThreadService: ThreadServiceProtocol {
  private let client: Client
  private let apikey: String
  
  init(client: Client, apikey: String) {
    self.client = client
    self.apikey = apikey
  }
  
    func getRouteStations(uid: String) async throws -> ThreadResponse {

    let response = try await client.getRouteStations(query: .init(
        apikey: apikey,
        uid: uid
        
    ))

    return try response.ok.body.json
  }
}


