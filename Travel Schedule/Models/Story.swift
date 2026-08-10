import Foundation

struct Story: Identifiable, Sendable {
    let id = UUID()
    let pages: [StoryPage]
    var isViewed: Bool = false
}
