//
//  ContentView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var viewIndex: ViewIndex
    @Query var views: [Item]

    var body: some View {
        EarthView(model: views[viewIndex.index])
            .statusBarHidden()
            .persistentSystemOverlays(.hidden)
    }
}
