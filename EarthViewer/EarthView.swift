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

    var body: some View {
        let imageView = ImageView(imageURL: model.image)

        ZStack(alignment: .bottomTrailing, content: {
            imageView
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .zIndex(0)

            DetailView(
                country: model.country,
                region: model.region,
                detailTapped: { openMaps() },
                saveTapped: { saveCurrentImage(imageView) }
            )
            .padding(.trailing, 8)
            .zIndex(1)
        })
    }

    private func openMaps() {
        if let url = URL(string: model.map) {
            UIApplication.shared.open(url)
        }
    }

    private func saveCurrentImage(_ view: ImageView) {
        let image = view.snapshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
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
