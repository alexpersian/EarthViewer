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
    @StateObject var viewIndex = ViewIndex()

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
            ContentView()
                .environmentObject(viewIndex)
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
                var models = try JSONDecoder().decode([Item].self, from: data)
                models.sort { $0.id < $1.id }
                models.forEach { container.mainContext.insert($0) }
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
    }
}
