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
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(systemName: "hourglass")!.withTintColor(.secondarySystemBackground), url: nil)
    }

    // This is what gets displayed within the widget gallery
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), image: UIImage(systemName: "globe.americas.fill")!.withTintColor(.secondarySystemBackground), url: nil)
        completion(entry)
    }

    // This is what provides the data for the widget to something
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

            let entry = SimpleEntry(date: Date(), image: image, url: entryURL)
            let refreshDate = Calendar.current.date(
                byAdding: .hour,
                value: 6,
                to: .now
            )!
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
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
            .containerBackground(for: .widget, content: { Color.primary})
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
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    EarthViewerWidget()
} timeline: {
    let data = try! Data(contentsOf: URL(string: "https://www.gstatic.com/prettyearth/assets/full/14793.jpg")!)
    let image = UIImage(data: data)
    SimpleEntry(date: Date(), image: image!, url: nil)
}
