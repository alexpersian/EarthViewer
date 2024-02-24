import SwiftUI

struct ImageView: View {
    @ObservedObject var remoteImageLoader: RemoteImageLoader

    init(_ imageURL: String) {
        guard let url = URL(string: imageURL) else {
            fatalError("Error: Invalid image URL provided.")
        }
        remoteImageLoader = RemoteImageLoader(imageURL: url)
    }

    var body: some View {
        if let image = UIImage(data: remoteImageLoader.data) {
            Image(uiImage: image)
                .resizable()
                .transition(.opacity.animation(.default))
        } else {
            ProgressView()
                .transition(.opacity.animation(.default))
        }
    }
}

#Preview {
    ImageView("https://www.gstatic.com/prettyearth/assets/full/1004.jpg")
}
