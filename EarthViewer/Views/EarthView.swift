//
//  EarthView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import SwiftUI
import SwiftData

struct EarthView: View {
    @State private var saveSuccess: Bool = false
    @State private var showFavorites: Bool = false
    @State private var showDetails: Bool = true

    let model: Item
    let requestViewChange: (ViewChangeRequest) -> Void

    var body: some View {
        let imageView = ImageView(model.image)
        let detailView = DetailView(
            model: model,
            openMapsLinkTapped: { openMaps() },
            saveTapped: { saveImage(imageView) },
            favoriteTapped: { markFavorite() },
            openFavoritesTapped: { showFavoritesList() }
        )

        GeometryReader { proxy in
            ZStack(alignment: .bottom, content: {
                imageView
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .onTapGesture(coordinateSpace: .global) { loc in
                        changeImage(advance: loc.x > proxy.size.width / 2)
                    }
                    .onLongPressGesture {
                        showDetails.toggle()
                    }

                if showDetails {
                    detailView
                        .padding(.horizontal, 8)
                        .zIndex(1)
                        .transition(.opacity.animation(.easeInOut))
                }
            })
            .background(.black)
            .overlay {
                if saveSuccess {
                    ConfirmationView()
                        .transition(.opacity.animation(.easeInOut))
                }
            }
            .navigationDestination(
                isPresented: $showFavorites,
                destination: { FavoritesView(tappedFavorite: loadFavorite) }
            )
        }
    }

    private func changeImage(advance: Bool) {
        requestViewChange(advance ? .advance : .rewind)
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

    private func loadFavorite(id: String) {
        requestViewChange(.to(id: id))
    }
}

#Preview {
    return EarthView(
        model: Item.mock,
        requestViewChange: { _ in }
    )
}
