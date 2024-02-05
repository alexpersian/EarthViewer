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
                .renderingMode(.original)
                .scaledToFill()
                .ignoresSafeArea()
                .transition(.opacity.animation(.default))
        } else {
            ProgressView()
                .transition(.opacity.animation(.default))
        }
    }
}

final class RemoteImageLoader: ObservableObject {
    @Published var data: Data = Data()

    init(imageURL: URL) {
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let data = data {
                DispatchQueue.main.async { self.data = data }
            }
            else if let error = error {
                print("Error with image fetch: \(error)")
            }
        }
        .resume()
    }
}

#Preview {
    ImageView("https://www.gstatic.com/prettyearth/assets/full/1004.jpg")
}
