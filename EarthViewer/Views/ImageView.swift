import SwiftUI

struct ImageView: View, Equatable {
    @ObservedObject private var remoteImageLoader: RemoteImageLoader

    private let imageURL: URL
    private let isThumbnail: Bool

    init(_ imageURL: String, isThumbnail: Bool) {
        guard let url = URL(string: imageURL) else {
            fatalError("Error: Invalid image URL provided.")
        }
        self.imageURL = url
        self.isThumbnail = isThumbnail
        remoteImageLoader = RemoteImageLoader(imageURL: url)
    }

    var body: some View {
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
