import SwiftUI

struct DetailView: View {
    var model: Item
    var detailTapped: () -> Void
    var saveTapped: () -> Void
    var favoriteTapped: () -> Void

    var body: some View {
        HStack(spacing: 12, content: {
            VStack(alignment: .trailing) {
                Text(format(country: model.country, region: model.region))
                    .lineLimit(1)
                    .font(.headline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                Text("Google Maps")
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .underline()
                    .padding(.bottom, 2)
                Text(model.attribution)
                    .lineLimit(1)
                    .font(.caption2)
                    .foregroundStyle(.white)
                    .italic()
            }
            .onTapGesture { detailTapped() }

            Image(systemName: "photo.badge.arrow.down")
                .font(.title2)
                .foregroundStyle(.white)
                .padding(.top, 8)
                .onTapGesture { saveTapped() }

            Image(systemName: model.faveData.isFaved ? "star.fill" : "star")
                .font(.title2)
                .foregroundStyle(.white)
                .padding(.top, 4)
                .onTapGesture { favoriteTapped() }
        })
        .padding([.horizontal, .bottom], 12)
        .padding(.top, 8)
        .background(Color.black.opacity(0.55))
        .cornerRadius(4)
    }

    // Helper function for formatting since country and region can be empty strings
    private func format(country: String, region: String) -> String {
        return [region, country]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }
}

#Preview {
    return DetailView(
        model: Item.mock,
        detailTapped: {},
        saveTapped: {},
        favoriteTapped: {}
    )
}
