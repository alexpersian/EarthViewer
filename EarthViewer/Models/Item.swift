//
//  Item.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import Foundation
import SwiftData

@Model
final class Item: Decodable, Identifiable {
    @Attribute(.unique) let id: String
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

// MARK: - Formatting

extension Item {
    // Helper for formatting since region or country can be empty strings
    var regionCountryString: String {
        return [region, country]
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }
}

// MARK: - Mock Data

extension Item {
    static let mock = Item(
        id: "1004",
        image: "https://www.gstatic.com/prettyearth/assets/full/1010.jpg",
        country: "Country Name",
        region: "Really Super Duper Long",
        map: "https://www.google.com/maps/@-19.140249,-68.683995,14z/data=!3m1!1e3",
        attribution: "©2019 CNES / Astrium, Cnes/Spot Image, Maxar Technologies",
        faveData: FavoriteData(isFaved: true, timestamp: Date())
    )
}
