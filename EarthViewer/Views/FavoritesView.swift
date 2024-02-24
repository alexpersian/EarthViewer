//
//  FavoritesView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/24/24.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query(filter: #Predicate<Item> { $0.faveData.isFaved }, sort: [SortDescriptor(\.faveData.timestamp)]) var favorites: [Item]

    var body: some View {
        NavigationView {
            List(favorites) {
                PreviewView(model: $0)
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
}
