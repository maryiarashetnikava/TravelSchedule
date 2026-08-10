import SwiftUI

struct StoriesView: View {

    @State private var viewModel: StoriesViewModel
    
    init(stories: [Story]) {
        _viewModel = State(
            initialValue: StoriesViewModel(stories: stories)
        )
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(Array(viewModel.stories.enumerated()), id: \.element.id) { index, story in
                    StoryPreviewCell(story: story)
                        .onTapGesture {
                            viewModel.showStory(at: index)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
        .fullScreenCover(isPresented: $viewModel.isStoryPresented) {
            StoryView(
                story: viewModel.currentStory,
                onFinished: {
                    viewModel.finishStory()
                },
                onPreviousStory: {
                    viewModel.previousStory()
                }
            )
            .id(viewModel.displayedStoryIndex)
        }
        .frame(height: 196)
    }
}

#Preview {
    StoriesView(stories: StoriesMock.stories)
}
