//
//  ContentView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var views: [Item]
    @StateObject private var viewIndex = ViewIndex()

    var body: some View {
        EarthView(
            model: views[viewIndex.index],
            requestViewChange: handle(request:)
        )
        .statusBarHidden()
        .persistentSystemOverlays(.hidden)
        .onOpenURL(perform: { url in
            guard
                let id = url.absoluteString.split(separator: "/").last,
                let index = views.firstIndex(where: { $0.id == String(id) })
            else {
                print("Invalid index passed.")
                return
            }
            viewIndex.index = index
        })
    }

    private func handle(request: ViewChangeRequest) {
        switch request {
        case .advance:
            viewIndex.advance()
        case .rewind:
            viewIndex.rewind()
        case .to(let id):
            if let index = views.firstIndex(where: { $0.id == id }) {
                viewIndex.index = index
            }
        }
    }
}

enum ViewChangeRequest {
    case advance
    case rewind
    case to(id: String)
}
