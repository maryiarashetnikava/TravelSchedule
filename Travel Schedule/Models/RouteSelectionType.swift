
enum RouteSelectionType: Identifiable, Sendable {
    case departure
    case destination

    var id: Self {
        self
    }
}
