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
        NavigationStack {
            EarthView(
                model: views[viewIndex.index],
                requestViewChange: handle(request:)
            )
            .statusBarHidden(true)
            .persistentSystemOverlays(.hidden)
            .onOpenURL(perform: { url in
                guard let id = url.absoluteString.split(separator: "/").last else {
                    print("Unable to parse id from url.")
                    return
                }
                handle(request: .to(id: "\(id)"))
            })
        }
    }

    private func handle(request: ViewChangeRequest) {
        switch request {
        case .advance:
            viewIndex.advance()
        case .rewind:
            viewIndex.rewind()
        case .to(let id):
            if let newIndex = views.firstIndex(where: { $0.id == id }) {
                try? viewIndex.setIndex(to: newIndex)
            }
        case .random:
            // Unimplemented
            return
        }
    }
}
