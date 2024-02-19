import UIKit

final class RemoteImageLoader: ObservableObject {
    @Published var data: Data = Data()

    private let session: SessionManager = .shared

    init(imageURL: URL) {
        fetchImageData(for: imageURL)
    }

    func fetchImageData(for url: URL) {
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async { self.data = data }
            }
            else if let error = error {
                print("Image fetch error: \(error)")
            }
        }
        .resume()
    }
}
