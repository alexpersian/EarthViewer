//
//  FavoritesView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/24/24.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    // This is a SwiftUI defined object that allows for popping a view from the nav stack
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewIndex: ViewIndex

    // TODO: Find a better way to reset the index than pulling in entire items here
    @Query var items: [Item]
    @Query(
        filter: #Predicate<Item> { $0.faveData.isFaved },
        sort: [SortDescriptor(\.faveData.timestamp, order: .reverse)]
    ) var favorites: [Item]

    var body: some View {
            List(favorites) { item in
                PreviewView(model: item)
                    .onTapGesture { self.cardTapped(item.id) }
            }
            .scrollContentBackground(.hidden)
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle("Favorites")
    }

    private func cardTapped(_ id: String) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            viewIndex.index = index
            dismiss()
        }
    }
}

#Preview {
    FavoritesView()
}
