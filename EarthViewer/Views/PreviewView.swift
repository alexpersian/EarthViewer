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
            ImageView(model.image, isThumbnail: true, isForList: true)
                .aspectRatio(3/2, contentMode: .fill) // source images are 1800x1200
                .cornerRadius(8)
            Text(model.regionCountryString)
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    return PreviewView(model: Item.mock)
}
