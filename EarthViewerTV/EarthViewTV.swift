//
//  EarthViewTV.swift
//  EarthViewerTV
//
//  Created by Alex Persian on 8/1/24.
//

import SwiftUI

struct EarthViewTV: View {
    @State private var showDetails: Bool = true

    let model: Item
    let requestViewChange: (ViewChangeRequest) -> Void

    var body: some View {
        let imageView = ImageView(model.image, isThumbnail: false)
        let detailView = DetailViewTV(model: model)

        ZStack(alignment: .bottomTrailing, content: {
            imageView
                .scaledToFill()
                .ignoresSafeArea()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

            if showDetails {
                detailView
                    .zIndex(1)
                    .transition(.opacity.animation(.easeInOut))
            }
        })
        .focusable()
        .onMoveCommand(perform: { direction in
            switch direction {
            case .left:
                requestViewChange(.rewind)
            case .right:
                requestViewChange(.advance)
            case .up:
                showDetails = true
            case .down:
                showDetails = false
            default:
                return
            }
        })
    }
}

#Preview {
    EarthViewTV(
        model: Item.mock,
        requestViewChange: { _ in }
    )
}
