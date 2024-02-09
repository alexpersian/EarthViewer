//
//  Item.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import Foundation
import SwiftData

@Model
final class Item: Codable {
    let id: String
    let image: String
    let country: String
    let region: String
    let map: String
    let attribution: String

    enum CodingKeys: String, CodingKey {
        case id
        case image
        case country
        case region
        case map
        case attribution
    }

    init(id: String, image: String, country: String, region: String, map: String, attribution: String) {
        self.id = id
        self.image = image
        self.country = country
        self.region = region
        self.map = map
        self.attribution = attribution
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.country = try container.decode(String.self, forKey: .country)
        self.region = try container.decode(String.self, forKey: .region)
        self.map = try container.decode(String.self, forKey: .map)
        self.attribution = try container.decode(String.self, forKey: .attribution)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(image, forKey: .image)
        try container.encode(country, forKey: .country)
        try container.encode(region, forKey: .region)
        try container.encode(map, forKey: .map)
        try container.encode(attribution, forKey: .attribution)
    }
}
