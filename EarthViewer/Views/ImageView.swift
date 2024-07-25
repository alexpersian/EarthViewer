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
        if isThumbnail {
            if let image = remoteImageLoader.thumbnailImage {
                Image(uiImage: image)
                    .resizable()
                    .transition(.opacity.animation(.default))
            } else {
                ProgressView()
                    .transition(.opacity.animation(.default))
            }
        }
        else {
            if let image = remoteImageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .transition(.opacity.animation(.default))
            } else {
                ProgressView()
                    .transition(.opacity.animation(.default))
            }
        }
    }
}

#Preview {
    ImageView(Item.mock.image, isThumbnail: false)
}
