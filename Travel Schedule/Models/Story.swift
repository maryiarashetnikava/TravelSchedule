import Foundation

struct Story: Identifiable {
    let id = UUID()
    let pages: [StoryPage]
    var isViewed: Bool = false
}
