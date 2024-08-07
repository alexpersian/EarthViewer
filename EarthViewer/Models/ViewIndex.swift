//
//  ViewIndex.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/24/24.
//

import Foundation

// This is a hard-coded value based on the data available for Google Earth View images
fileprivate let numberOfImagesAvailable: Int = 2604

enum ViewIndexError: Error {
    case invalidIndex
}

final class ViewIndex: ObservableObject {
    private let range: Range<Int>

    /// `index` is seeded randomly on initalization.
    /// It can be adjusted using the `advance`, `rewind`, `random`, or `setIndex` functions.
    @Published private(set) var index: Int

    /// By default this initializes with the range `0..<numberOfImagesAvailable`, which
    /// is based off the number of Google Earth View images currently available.
    init(range: Range<Int> = 0..<numberOfImagesAvailable) {
        self.range = range
        self.index = .random(in: range)
    }

    /// Increments the index by `1`. If this would result in going out of bounds the index wraps around.
    func advance() {
        index = index + 1 < range.upperBound	
        ? index + 1
        : range.lowerBound
    }

    /// Decrements the index by `1`. If this would result in going out of bounds the index wraps around.
    func rewind() {
        index = index - 1 >= range.lowerBound
        ? index - 1
        : range.upperBound - 1
    }

    /// Sets the index to a random value within its range.
    func random() {
        index = .random(in: range)
    }

    /// Sets the current view index to the new value.
    ///
    /// - Throws: `invalidIndex` error if provided value is outside of the valid range.
    func setIndex(to newIndex: Int) throws {
        guard range.contains(newIndex) else {
            throw ViewIndexError.invalidIndex
        }
        index = newIndex
    }
}
