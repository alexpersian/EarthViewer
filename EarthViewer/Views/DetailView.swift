import SwiftUI

struct DetailView: View {
    let model: Item

    let openMapsLinkTapped: () -> Void
    let saveTapped: () -> Void
    let favoriteTapped: () -> Void
    let openFavoritesTapped: () -> Void

    @State private var showingDialog: Bool = false

    var body: some View {
        HStack(spacing: 12, content: {
            VStack(alignment: .leading) {
                Text(model.regionCountryString)
                    .lineLimit(1)
                    .font(.headline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                Text("See in Google Maps")
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .underline()
                    .padding(.bottom, 2)
                    .onTapGesture { openMapsLinkTapped() }
                Text(model.attribution)
                    .lineLimit(1)
                    .font(.caption2)
                    .foregroundStyle(.white)
                    .italic()
            }

            Spacer()

            Image(systemName: "photo.badge.arrow.down")
                .font(.title2)
                .foregroundStyle(.white)
                .padding(.top, 8)
                .onTapGesture { saveTapped() }

            Image(systemName: model.faveData.isFaved ? "star.fill" : "star")
                .font(.title2)
                .foregroundStyle(.white)
                .padding(.top, 2)
                .onTapGesture { favoriteTapped() }

            Image(systemName: "folder")
                .font(.title2)
                .foregroundStyle(.white)
                .padding(.top, 4)
                .onTapGesture { openFavoritesTapped() }
        })
        .padding([.horizontal, .bottom], 12)
        .padding(.top, 8)
        .background(Color.black.opacity(0.55))
        .cornerRadius(4)
    }
}

#Preview {
    return DetailView(
        model: Item.mock,
        openMapsLinkTapped: {},
        saveTapped: {},
        favoriteTapped: {},
        openFavoritesTapped: {}
    )
}
