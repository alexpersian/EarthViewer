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
            Spacer()
        }
    }

    private func format(region: String, country: String) -> String {
        return [region, country]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }
}

#Preview {
    return PreviewView(model: Item.mock)
}
