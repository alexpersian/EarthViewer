import SwiftUI

struct DetailView: View {

    var country: String
    var region: String
    var detailTapped: () -> Void
    var saveTapped: () -> Void

    var body: some View {
        HStack(spacing: 12, content: {
            VStack(alignment: .trailing) {
                Text(format(country: country, region: region))
                    .font(.headline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                Text("Google Maps")
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .underline()
            }
            .onTapGesture { detailTapped() }

            Image(systemName: "square.and.arrow.down")
                .font(.title)
                .foregroundStyle(.white)
                .onTapGesture { saveTapped() }
        })
        .padding(.horizontal, 12)
        .padding(.bottom, 12)
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
        country: "Chile", 
        region: "Tamarugal",
        detailTapped: {},
        saveTapped: {}
    )
}
