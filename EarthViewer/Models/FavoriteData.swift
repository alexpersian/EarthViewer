//
//  FavoriteData.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/25/24.
//

import Foundation
import SwiftData

@Model
final class FavoriteData {
    /// Whether the Item is a favorite or not
    var isFaved: Bool
    /// Timestamp of when an Item was marked as favorite. Only relevant if `isFaved = true`.
    var timestamp: Date

    init(isFaved: Bool, timestamp: Date) {
        self.isFaved = isFaved
        self.timestamp = timestamp
    }
}
