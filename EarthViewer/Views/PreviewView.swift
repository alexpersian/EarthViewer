//
//  PreviewView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/24/24.
//

import SwiftUI

struct PreviewView: View {
    let model: Item

    var body: some View {
        VStack(alignment: .leading) {
            ImageView(model.image)
                .scaledToFill()
                .cornerRadius(8)
            Text(format(region: model.region, country: model.country))
        }
    }

    private func format(region: String, country: String) -> String {
        return [region, country]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }
}

#Preview {
    let item = Item(
        id: "",
        image: "https://www.gstatic.com/prettyearth/assets/full/1010.jpg",
        country: "Country Name",
        region: "Really Super Duper Long",
        map: "",
        attribution: "",
        faveData: FavoriteData(isFaved: true, timestamp: Date())
    )
    return PreviewView(model: item)
}
