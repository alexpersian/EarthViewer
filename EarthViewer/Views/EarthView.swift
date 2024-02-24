//
//  EarthView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import SwiftUI
import SwiftData

struct EarthView: View {
    @EnvironmentObject var viewIndex: ViewIndex
    @State var saveSuccess: Bool = false
    @State var showFavorites: Bool = false

    var model: Item

    var body: some View {
        let imageView = ImageView(model.image)

        NavigationStack {
            GeometryReader { proxy in
                ZStack(alignment: .bottomTrailing, content: {
                    imageView
                        .scaledToFill()
                        .ignoresSafeArea()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .zIndex(0)
                        .onTapGesture(coordinateSpace: .global) { loc in
                            changeImage(advance: loc.x > proxy.size.width / 2)
                        }

                    DetailView(
                        model: model,
                        detailTapped: { openMaps() },
                        saveTapped: { saveImage(imageView) },
                        favoriteTapped: { markFavorite() },
                        openFavoritesTapped: { showFavoritesList() }
                    )
                    .padding(.horizontal, 8)
                    .zIndex(1)
                })
                .overlay {
                    if saveSuccess {
                        ConfirmationView()
                            .transition(.opacity.animation(.easeInOut))
                    }
                }
                .navigationDestination(
                    isPresented: $showFavorites,
                    destination: { FavoritesView() }
                )
            }
        }
        .tint(.black)
    }

    private func changeImage(advance: Bool) {
        advance ? viewIndex.advance() : viewIndex.rewind()
    }

    private func openMaps() {
        if let url = URL(string: model.map) {
            UIApplication.shared.open(url)
        }
    }

    @MainActor private func saveImage(_ view: ImageView) {
        let renderer = ImageRenderer(content: view)
        if let image = renderer.uiImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            // This is not great because we don't actually know the result of the save.
            // Since we can't use #selector and @objc within SwiftUI space to have showConfirmation
            // be the completionSelector I'm leaving this as a limitation for now.
            showConfirmation()
        }
    }

    private func showConfirmation() {
        saveSuccess = true
        let work = DispatchWorkItem { saveSuccess = false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: work)
    }

    private func markFavorite() {
        let newFaveData = FavoriteData(isFaved: !model.faveData.isFaved, timestamp: Date())
        model.faveData = newFaveData
    }

    private func showFavoritesList() {
        showFavorites = true
    }
}

#Preview {
    return EarthView(model: Item.mock)
}
