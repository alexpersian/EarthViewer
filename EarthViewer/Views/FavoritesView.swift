//
//  FavoritesView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/24/24.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    // This is a SwiftUI defined object that pops a view from the nav stack
    @Environment(\.dismiss) private var dismiss
    @Query(
        filter: #Predicate<Item> { $0.faveData.isFaved },
        sort: [SortDescriptor(\.faveData.timestamp, order: .reverse)]
    ) private var favorites: [Item]

    let tappedFavorite: (String) -> Void

    var body: some View {
            List(favorites) { item in
                PreviewView(model: item)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        tappedFavorite(item.id)
                        dismiss()
                    }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle("Favorites")
    }
}

#Preview {
    FavoritesView { _ in }
}
