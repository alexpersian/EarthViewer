import Foundation

final class SessionManager {

    static let shared: SessionManager = SessionManager()

    private let session: URLSession
    private let cache: URLCache

    private init() {
        let cache = URLCache(
            memoryCapacity: 10 * 1024 * 1024,   // 10MB
            diskCapacity: 20 * 1024 * 1024      // 20MB
        )
        let config = URLSessionConfiguration.default
        config.urlCache = cache
        config.requestCachePolicy = .returnCacheDataElseLoad

        self.session = URLSession(configuration: config)
        self.cache = cache
    }

    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        session.dataTask(with: url, completionHandler: completionHandler)
    }

    func dataTask(with url: URL) async -> Data? {
        if let (data, _) = try? await session.data(from: url) {
            return data
        } else {
            return nil
        }
    }
}
