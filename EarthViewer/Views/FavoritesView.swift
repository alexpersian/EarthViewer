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
        GeometryReader { proxy in
            ScrollView {
                LazyVGrid(
                    columns: getColumns(for: proxy.size),
                    content: {
                        ForEach(favorites) { item in
                            PreviewView(model: item)
                                .frame(maxWidth: getMaxWidth(for: proxy.size))
                                .onTapGesture {
                                    tappedFavorite(item.id)
                                    dismiss()
                                }
                        }
                    }
                )
                .padding(.horizontal, 8)
            }
        }
        .toolbarTitleDisplayMode(.inlineLarge)
        .navigationTitle("Favorites")
    }

    // >500 width means we are either on an iPad or in landscape*
    // *non-Plus iPhones still use .compact sizeClass for landscape
    private let widthBreakpoint: CGFloat = 500

    private func getColumns(for size: CGSize) -> [GridItem] {
        return size.width > widthBreakpoint ? [GridItem(), GridItem()] : [GridItem()]
    }

    private func getMaxWidth(for size: CGSize) -> CGFloat {
        return size.width > widthBreakpoint ? size.width / 2 : size.width
    }
}

#Preview {
    FavoritesView { _ in }
}
