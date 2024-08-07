import SwiftUI

struct ImageView: View {
    @ObservedObject private var remoteImageLoader: RemoteImageLoader

    private let isThumbnail: Bool

    init(_ imageURL: String, isThumbnail: Bool) {
        guard let url = URL(string: imageURL) else {
            fatalError("Error: Invalid image URL provided.")
        }
        remoteImageLoader = RemoteImageLoader(imageURL: url)
        self.isThumbnail = isThumbnail
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
}

#Preview {
    ImageView(Item.mock.image, isThumbnail: false)
}
