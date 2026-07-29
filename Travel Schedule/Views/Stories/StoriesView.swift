import SwiftUI

struct StoriesView: View {

    @State private var stories: [Story]
    
    @State private var isStoryPresented = false
    @State private var displayedStoryIndex = 0
    
    init(stories: [Story]) {
        _stories = State(initialValue: stories)
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                    StoryPreviewCell(story: story)
                        .onTapGesture {
                            displayedStoryIndex = index
                            isStoryPresented = true
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .fullScreenCover(isPresented: $isStoryPresented) {
            StoryView(
                story: stories[displayedStoryIndex],
                onFinished: {
                        stories[displayedStoryIndex].isViewed = true
                    
                    if displayedStoryIndex < stories.count - 1 {
                        displayedStoryIndex += 1
                    } else {
                        isStoryPresented = false
                    }
                },
                
                onPreviousStory: {
                    if displayedStoryIndex > 0 {
                        displayedStoryIndex -= 1
                    }
                }
            )
            .id(displayedStoryIndex)
        }
        .frame(height: 196)
    }
}

#Preview {
    StoriesView(stories: StoriesMock.stories)
}
