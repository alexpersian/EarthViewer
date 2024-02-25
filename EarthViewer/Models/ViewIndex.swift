//
//  ViewIndex.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/24/24.
//

import Foundation

final class ViewIndex: ObservableObject {
     // Using a hard coded range here only because our data size is fixed.
    private static let range = 0..<2604

    // `index` is seeded randomly on app start.
    @Published var index: Int = .random(in: range)

    func advance() {
        index = index + 1 < Self.range.upperBound
        ? index + 1
        : Self.range.lowerBound
    }

    func rewind() {
        index = index - 1 >= Self.range.lowerBound
        ? index - 1
        : Self.range.upperBound - 1
    }
}
