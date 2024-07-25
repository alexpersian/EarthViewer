//
//  DataManager.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/28/24.
//

import Foundation
import SwiftData

actor DataManager {

    private let container: ModelContainer
    private let context: ModelContext

    init() {
        do {
            container = try ModelContainer(for: Item.self)
            context = ModelContext(container)
        } catch {
            fatalError("Failed to initialize model container.")
        }
    }

    func getAllItems() throws -> [Item] {
        return try context.fetch(FetchDescriptor<Item>())
    }

    func getFavorites() throws -> [Item] {
        return try context.fetch(FetchDescriptor<Item>(
            predicate: #Predicate<Item> { $0.faveData.isFaved },
            sortBy: [SortDescriptor(\.faveData.timestamp, order: .reverse)]
        ))
    }
}
