import SwiftUI
import Observation

@MainActor
@Observable
final class StoryViewModel {

    let story: Story

    var currentPage = 0
    var pageProgress: CGFloat = 0

    private let configuration = Configuration()

    init(story: Story) {
        self.story = story
    }

    var progress: CGFloat {
        (CGFloat(currentPage) + pageProgress) / CGFloat(story.pages.count)
    }

    func timerTick() -> Bool {
        let nextPageProgress = pageProgress + configuration.progressPerTick

        if nextPageProgress >= 1 {
            return nextPage()
        }

        pageProgress = nextPageProgress
        return false
    }

    func nextPage() -> Bool {
        if currentPage < story.pages.count - 1 {
            currentPage += 1
            pageProgress = 0
            return false
        } else {
            return true
        }
    }

    func previousPage() -> Bool {
        if currentPage > 0 {
            currentPage -= 1
            pageProgress = 0
            return false
        } else {
            return true
        }
    }
}

private struct Configuration {
    let storyDuration: TimeInterval = 10
    let timerTickInterval: TimeInterval = 0.01

    var progressPerTick: CGFloat {
        CGFloat(timerTickInterval / storyDuration)
    }
}
