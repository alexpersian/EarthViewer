//
//  EarthViewerApp.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import SwiftUI
import SwiftData

@main
struct EarthViewerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Item.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            // Seed ContentView with a random view index to start.
            // Hard coded max is bad, but data size is known and fixed.
            ContentView(viewIndex: .random(in: 0..<1520))
        }
        .modelContainer(for: Item.self) { result in
            do {
                let container = try result.get()

                // Check for existing data
                let existingData = try container.mainContext.fetchCount(FetchDescriptor<Item>())
                guard existingData <= 0 else { return }

                // Load JSON data file
                guard let url = Bundle.main.url(forResource: "earthviews", withExtension: "json") else {
                    fatalError("Unable to load initial data file.")
                }

                // Decode JSON into initial models and populate database
                let data = try Data(contentsOf: url)
                let models = try JSONDecoder().decode([Item].self, from: data)
                models.forEach { container.mainContext.insert($0) }
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
    }
}
