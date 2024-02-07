import SwiftUI

struct DetailView: View {
    var model: Item
    var detailTapped: () -> Void
    var saveTapped: () -> Void

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
    let item = Item(
        id: "",
        image: "",
        country: "Argentina",
        region: "Volodarsky District, Astrakhan Oblast",
        map: "",
        attribution: "©2019 Aerodata International Surveys, Maxar Technologies, The GeoInformation Group | InterAtlas"
    )

    return DetailView(
        model: item,
        detailTapped: {},
        saveTapped: {}
    )
}
