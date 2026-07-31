import SwiftUI

struct StoryPreviewCell: View {

    let story: Story

    var body: some View {
        ZStack(alignment: .bottomLeading) {

            Image(story.pages.first?.imageName ?? "")
                .resizable()
                .scaledToFill()
                .frame(width: 92, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            Text(StoryConstants.title)
                .lineLimit(3)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
        }
        .frame(width: 92, height: 140)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    story.isViewed ? .clear : .ypBlue,
                    lineWidth: 4
                )
        }
        .opacity(story.isViewed ? 0.5 : 1)
    }
}

#Preview {
    StoryPreviewCell(story: StoriesMock.stories[0])
}
