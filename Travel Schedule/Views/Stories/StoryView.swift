import SwiftUI
import Combine

struct StoryView: View {
    
    let story: Story
    let onFinished: () -> Void
    let onPreviousStory: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentPage = 0
    @State private var pageProgress: CGFloat = 0
    
    private let configuration = Configuration()
    
    @State private var timer = Timer.publish(
        every: Configuration().timerTickInterval,
        on: .main,
        in: .common
    ).autoconnect()
    
    private var progress: CGFloat {
        (CGFloat(currentPage) + pageProgress) / CGFloat(story.pages.count)
    }
    
    var body: some View {
        ZStack {
            Color.ypBlackUniversal
                .ignoresSafeArea()
            
            Image(story.pages[currentPage].imageName)
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
                                if currentPage > 0 {
                                    currentPage -= 1
                                    pageProgress = 0
                                } else {
                                    onPreviousStory()
                                }
                            }
                        
                        Color.clear
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                nextPage()
                            }
                    }
                }
                .overlay(alignment: .top) {
                    ProgressBar(
                        numberOfSections: story.pages.count,
                        progress: progress
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
                            .truncationMode(.tail)
                        
                        Text(StoryConstants.description)
                            .font(.system(size: 20))
                            .lineLimit(3)
                            .truncationMode(.tail)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                    .onReceive(timer) { _ in
                        timerTick()
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < -50 {
                                nextPage()
                            } else if value.translation.width > 50 {
                                if currentPage > 0 {
                                    currentPage -= 1
                                    pageProgress = 0
                                } else {
                                    onPreviousStory()
                                }
                            }
                        }
                )
        }
    }
    
    private func timerTick() {
        var nextPageProgress = pageProgress + configuration.progressPerTick

        if nextPageProgress >= 1 {
            nextPage()
            return
        }

        pageProgress = nextPageProgress
    }
    
    private func nextPage() {
        if currentPage < story.pages.count - 1 {
            currentPage += 1
            pageProgress = 0
        } else {
            onFinished()
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


#Preview {
    StoryView(
        story: StoriesMock.stories[1],
        onFinished: { },
        onPreviousStory: { }
    )
}
