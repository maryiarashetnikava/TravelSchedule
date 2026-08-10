import Observation

@MainActor
@Observable
final class StoriesViewModel {

    var stories: [Story]

    var isStoryPresented = false
    var displayedStoryIndex = 0

    init(stories: [Story]) {
        self.stories = stories
    }

    var currentStory: Story {
        stories[displayedStoryIndex]
    }

    func showStory(at index: Int) {
        displayedStoryIndex = index
        isStoryPresented = true
    }

    func finishStory() {
        stories[displayedStoryIndex].isViewed = true

        if displayedStoryIndex < stories.count - 1 {
            displayedStoryIndex += 1
        } else {
            isStoryPresented = false
        }
    }

    func previousStory() {
        guard displayedStoryIndex > 0 else {
            return
        }

        displayedStoryIndex -= 1
    }
}
