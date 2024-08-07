//
//  ViewIndex.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/24/24.
//

import Foundation

final class ViewIndex: ObservableObject {
     // Using a hard coded range here only because our data size is fixed.
    private static let minRange = 0
    private static let maxRange = 2604
    private static let range = minRange..<maxRange

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

    func random() {
        index = .random(in: Self.range)
    }
}
