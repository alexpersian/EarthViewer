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

    let image: String
    let country: String
    let region: String
    let map: String

    enum CodingKeys: String, CodingKey {
        case image
        case country
        case region
        case map
    }

    init(image: String, country: String, region: String, map: String) {
        self.image = image
        self.country = country
        self.region = region
        self.map = map
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image = try container.decode(String.self, forKey: .image)
        self.country = try container.decode(String.self, forKey: .country)
        self.region = try container.decode(String.self, forKey: .region)
        self.map = try container.decode(String.self, forKey: .map)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(image, forKey: .image)
        try container.encode(country, forKey: .country)
        try container.encode(region, forKey: .region)
        try container.encode(map, forKey: .map)
    }
}
