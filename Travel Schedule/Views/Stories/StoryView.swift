import SwiftUI
import Combine

struct StoryView: View {

    let story: Story
    let onFinished: () -> Void
    let onPreviousStory: () -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: StoryViewModel

    @State private var timer = Timer.publish(
        every: 0.01,
        on: .main,
        in: .common
    ).autoconnect()

    init(
        story: Story,
        onFinished: @escaping () -> Void,
        onPreviousStory: @escaping () -> Void
    ) {
        self.story = story
        self.onFinished = onFinished
        self.onPreviousStory = onPreviousStory

        _viewModel = State(
            initialValue: StoryViewModel(story: story)
        )
    }

    var body: some View {
        ZStack {
            Color.ypBlackUniversal
                .ignoresSafeArea()

            Image(story.pages[viewModel.currentPage].imageName)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .contentShape(Rectangle())

                .overlay {
                    HStack(spacing: 0) {

                        Color.clear
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if viewModel.previousPage() {
                                    onPreviousStory()
                                }
                            }

                        Color.clear
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if viewModel.nextPage() {
                                    onFinished()
                                }
                            }
                    }
                }

                .overlay(alignment: .top) {
                    ProgressBar(
                        numberOfSections: story.pages.count,
                        progress: viewModel.progress
                    )
                    .padding(.horizontal, 12)
                    .padding(.top, 28)
                }

                .overlay(alignment: .topTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                            .background(.ypBlackUniversal.opacity(0.8))
                            .clipShape(Circle())
                    }
                    .padding(.top, 50)
                    .padding(.trailing, 12)
                }

                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading, spacing: 12) {

                        Text(StoryConstants.title)
                            .font(.system(size: 34, weight: .bold))
                            .lineLimit(2)

                        Text(StoryConstants.description)
                            .font(.system(size: 20))
                            .lineLimit(3)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                    .onReceive(timer) { _ in
                        if viewModel.timerTick() {
                            onFinished()
                        }
                    }
                }

                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < -50 {
                                if viewModel.nextPage() {
                                    onFinished()
                                }
                            } else if value.translation.width > 50 {
                                if viewModel.previousPage() {
                                    onPreviousStory()
                                }
                            }
                        }
                )
        }
    }
}

#Preview {
    StoryView(
        story: StoriesMock.stories[1],
        onFinished: { },
        onPreviousStory: { }
    )
}
