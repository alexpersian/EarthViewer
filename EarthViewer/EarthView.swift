//
//  EarthView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import SwiftUI
import SwiftData

struct EarthView: View {
    var model: Item
    @State var saveSuccess: Bool = false

    var body: some View {
        let imageView = ImageView(model.image)

        ZStack(alignment: .bottomTrailing, content: {
            imageView
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .zIndex(0)

            DetailView(
                country: model.country,
                region: model.region,
                detailTapped: { openMaps() },
                saveTapped: { saveImage(imageView) }
            )
            .padding(.trailing, 8)
            .zIndex(1)
        })
        .overlay {
            if saveSuccess {
                ConfirmationView()
                    .transition(.opacity.animation(.easeInOut))
            }
        }
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
}

#Preview {
    let item = Item(
        image: "https://www.gstatic.com/prettyearth/assets/full/1004.jpg",
        country: "Chile",
        region: "Tamarugal",
        map: "https://www.google.com/maps/@-19.140249,-68.683995,15z/data=!3m1!1e3"
    )
    return EarthView(model: item)
}
