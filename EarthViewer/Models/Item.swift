//
//  Item.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import Foundation
import SwiftData

@Model
final class Item: Decodable {
    let id: String
    let image: String
    let country: String
    let region: String
    let map: String
    let attribution: String
    var faveData: FavoriteData

    enum CodingKeys: String, CodingKey {
        case id
        case image
        case country
        case region
        case map
        case attribution
    }

    init(id: String, image: String, country: String, region: String, map: String, attribution: String, faveData: FavoriteData) {
        self.id = id
        self.image = image
        self.country = country
        self.region = region
        self.map = map
        self.attribution = attribution
        self.faveData = faveData
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.country = try container.decode(String.self, forKey: .country)
        self.region = try container.decode(String.self, forKey: .region)
        self.map = try container.decode(String.self, forKey: .map)
        self.attribution = try container.decode(String.self, forKey: .attribution)
        // faveData is a model store only property. JSON file never includes this.
        self.faveData = FavoriteData(isFaved: false, timestamp: Date())
    }
}

@Model
final class FavoriteData {
    /// Whether the Item is a favorite or not
    let isFaved: Bool
    /// Timestamp of when an Item was marked as favorite. Only relevant if `isFaved = true`.
    let timestamp: Date

    init(isFaved: Bool, timestamp: Date) {
        self.isFaved = isFaved
        self.timestamp = timestamp
    }
}
