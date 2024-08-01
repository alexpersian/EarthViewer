//
//  EarthViewTV.swift
//  EarthViewerTV
//
//  Created by Alex Persian on 8/1/24.
//

import SwiftUI

struct EarthViewTV: View {
    @State private var showDetails: Bool = true
    @State private var startDate: Date = .now
    @State private var elapsedTime: TimeInterval = 0

    let model: Item
    let requestViewChange: (ViewChangeRequest) -> Void

    private let viewChangeTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let viewChangeInterval: TimeInterval = 60

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
                changeView(.rewind)
            case .right:
                changeView(.advance)
            case .up:
                showDetails = true
            case .down:
                showDetails = false
            default:
                return
            }
        })
        .onReceive(viewChangeTimer) { fireDate in
            elapsedTime = fireDate.timeIntervalSince(startDate)
            if elapsedTime > viewChangeInterval {
                changeView(.random)
            }
        }
    }

    private func changeView(_ request: ViewChangeRequest) {
        requestViewChange(request)
        resetViewChangeCountdown()
    }

    private func resetViewChangeCountdown() {
        startDate = .now
        elapsedTime = 0
    }
}

#Preview {
    EarthViewTV(
        model: Item.mock,
        requestViewChange: { _ in }
    )
}
