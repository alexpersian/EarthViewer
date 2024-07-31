//
//  EarthViewerWidget.swift
//  EarthViewerWidget
//
//  Created by Alex Persian on 2/26/24.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    private let dataManager = DataManager()
    private let remoteImageLoader = RemoteImageLoader()

    // This is what's shown when the widget doesn't have data
    func placeholder(in context: Context) -> EarthViewEntry {
        EarthViewEntry(date: Date(), image: UIImage(imageLiteralResourceName: "earthview-placeholder"), url: nil)
    }

    // This is what gets displayed within the widget gallery
    func getSnapshot(in context: Context, completion: @escaping (EarthViewEntry) -> ()) {
        let entry = EarthViewEntry(date: Date(), image: UIImage(imageLiteralResourceName: "earthview-placeholder"), url: nil)
        completion(entry)
    }

    // This is what provides the data for the widget
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            guard
                let earthView = try? await dataManager.getAllItems().randomElement(),
                let imageURL = URL(string: earthView.image),
                let image = await remoteImageLoader.fetchImageData(for: imageURL)
            else {
                print("Failed to retrieve widget data.")
                completion(.init(entries: [], policy: .never))
                return
            }

            let entryURL = URL(string: "com.alexpersian.EarthView/\(earthView.id)")

            let entry = EarthViewEntry(date: Date(), image: image, url: entryURL)
            // Update every 8 hours. This should allow for a "fresh" feel without updating too often
            let refreshDate = Calendar.current.date(byAdding: .hour, value: 8, to: .now)!
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct EarthViewEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let url: URL?
}

struct EarthViewerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Image(uiImage: entry.image)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .containerBackground(for: .widget, content: { Color.primary })
            .widgetURL(entry.url)
    }
}

struct EarthViewerWidget: Widget {
    let kind: String = "EarthViewerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EarthViewerWidgetEntryView(entry: entry)
                .modelContainer(for: Item.self)
        }
        .configurationDisplayName("Earth View Highlight")
        .description("Displays a cycling Earth view picture.")
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    EarthViewerWidget()
} timeline: {
    let image = UIImage(imageLiteralResourceName: "earthview-placeholder")
    EarthViewEntry(date: Date(), image: image, url: nil)
}
