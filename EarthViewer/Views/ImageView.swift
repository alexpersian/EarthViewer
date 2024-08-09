import SwiftUI

struct ImageView: View, Equatable {
    @ObservedObject private var remoteImageLoader: RemoteImageLoader

    private let imageURL: URL
    private let isThumbnail: Bool
    private let isForList: Bool

    init(_ imageURL: String, isThumbnail: Bool = false, isForList: Bool = false) {
        guard let url = URL(string: imageURL) else {
            fatalError("Error: Invalid image URL provided.")
        }

        self.imageURL = url
        self.isThumbnail = isThumbnail
        self.isForList = isForList

        remoteImageLoader = RemoteImageLoader(imageURL: url)
    }

    var body: some View {
        if isForList {
            // Within a List the Image view causes self-sizing issues. Wrapping it in a clear
            // overlay view addresses these sizing issues.
            Color.clear.overlay { content }
        }
        else {
            // Other usages do not need the workaround.
            content
        }
    }

    @ViewBuilder var content: some View {
        let image = isThumbnail
        ? remoteImageLoader.thumbnailImage
        : remoteImageLoader.image

        if let image = image {
            Image(uiImage: image)
                .resizable()
                .transition(.opacity.animation(.default))
        } else {
            ProgressView()
                .colorInvert()
                .transition(.opacity.animation(.default))
        }
    }

    static func == (lhs: ImageView, rhs: ImageView) -> Bool {
        return lhs.imageURL == rhs.imageURL &&
            lhs.isThumbnail == rhs.isThumbnail
    }
}

#Preview {
    ImageView(Item.mock.image, isThumbnail: false)
}
