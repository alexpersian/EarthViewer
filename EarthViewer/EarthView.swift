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
        ZStack(alignment: .bottomTrailing, content: {
            AsyncImage(
                url: URL(string: model.image),
                scale: 1,
                transaction: Transaction(animation: .default),
                content: { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                    } else {
                        ProgressView()
                    }
                }
            )
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .zIndex(0)

            VStack {
                VStack(alignment: .trailing) {
                    Text(format(region: model.region, country: model.country))
                        .font(.headline)
                        .colorInvert()
                    Text("Google Maps")
                        .fontDesign(.serif)
                        .underline()
                        .colorInvert()
                }
                .padding(.horizontal, 12)
                .padding(.top, 8)
                .padding(.bottom, 10)
            }
            .background(Color.primary.opacity(0.65))
            .padding(.trailing, 8)
            .cornerRadius(4)
            .zIndex(1)
            .onTapGesture {
                UIApplication.shared.open(URL(string: model.map)!)
            }
        })
    }

    // Helper function for formatting since country and region can be empty strings
    private func format(region: String, country: String) -> String {
        return [region, country]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }
}
