//
//  ContentViewTV.swift
//  EarthViewerTV
//
//  Created by Alex Persian on 8/1/24.
//

import SwiftUI
import SwiftData

struct ContentViewTV: View {
    @Query private var views: [Item]
    @StateObject private var viewIndex = ViewIndex()

    var body: some View {
        EarthViewTV(
            model: views[viewIndex.index],
            requestViewChange: handle(request:)
        )
    }

    private func handle(request: ViewChangeRequest) {
        switch request {
        case .advance:
            viewIndex.advance()
        case .rewind:
            viewIndex.rewind()
        case .to:
            // Not implemented on tvOS
            return
        }
    }
}
