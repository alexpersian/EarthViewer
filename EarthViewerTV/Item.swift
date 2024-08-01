//
//  Item.swift
//  EarthViewerTV
//
//  Created by Alex Persian on 8/1/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
