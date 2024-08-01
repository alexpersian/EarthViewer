//
//  DetailViewTV.swift
//  EarthViewerTV
//
//  Created by Alex Persian on 8/1/24.
//

import SwiftUI

struct DetailViewTV: View {
    let model: Item

    var body: some View {
        HStack(spacing: 12, content: {
            VStack(alignment: .trailing) {
                Text(model.regionCountryString)
                    .lineLimit(1)
                    .font(.body)
                    .foregroundStyle(.white)
                Text(model.attribution)
                    .lineLimit(1)
                    .font(.caption2)
                    .foregroundStyle(.white)
                    .italic()
            }
        })
        .padding([.horizontal, .bottom], 12)
        .padding(.top, 8)
        .background(Color.black.opacity(0.55))
        .cornerRadius(4)
    }
}

#Preview {
    return DetailViewTV(
        model: Item.mock
    )
}
