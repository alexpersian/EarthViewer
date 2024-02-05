import SwiftUI

struct ImageView: View {

    var imageURL: String

    var body: some View {
        AsyncImage(
            url: URL(string: imageURL),
            scale: 1,
            transaction: Transaction(animation: .default),
            content: { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                case .failure(_):
                    Image(systemName: "network.slash")
                        .font(.title)
                        .colorInvert()
                default:
                    fatalError("Error: unhandled phase state.")
                }
            }
        )
    }
}

#Preview {
    ImageView(imageURL: "https://www.gstatic.com/prettyearth/assets/full/1004.jpg")
}
