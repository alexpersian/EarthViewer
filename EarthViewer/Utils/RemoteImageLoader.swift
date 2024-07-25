import UIKit

final class RemoteImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var thumbnailImage: UIImage?

    private let session: SessionManager = .shared
    private let thumbnailSize = CGSize(width: 540, height: 480)

    init(imageURL: URL) {
        fetchImageData(for: imageURL)
    }

    init() {}

    func fetchImageData(for url: URL) {
        session.dataTask(with: url) { data, response, error in
            if let data = data, let tmp = UIImage(data: data), let thumbnail = tmp.preparingThumbnail(of: self.thumbnailSize) {
                DispatchQueue.main.async {
                    self.image = tmp
                    self.thumbnailImage = thumbnail
                }
            }
            else if let error = error {
                print("Image fetch error: \(error)")
            }
        }
        .resume()
    }

    func fetchImageData(for url: URL) async -> UIImage? {
        if let data = await session.dataTask(with: url) {
            if let tmp = UIImage(data: data), let thumbnail = tmp.preparingThumbnail(of: self.thumbnailSize) {
                return thumbnail
            }
        }
        return nil
    }
}
