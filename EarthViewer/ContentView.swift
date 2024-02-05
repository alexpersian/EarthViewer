//
//  ContentView.swift
//  EarthViewer
//
//  Created by Alex Persian on 2/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var views: [Item]
    @State var viewIndex: Int

    var body: some View {
        GeometryReader { proxy in
            EarthView(model: views[viewIndex])
                .statusBarHidden()
                .persistentSystemOverlays(.hidden)
                .onTapGesture(coordinateSpace: .global) { location in
                    // Right side
                    if location.x > proxy.size.width / 2 {
                        var tmp = viewIndex + 1
                        if tmp > views.count - 1 { tmp = 0 }
                        viewIndex = tmp
                    }
                    // Left side
                    else {
                        var tmp = viewIndex - 1
                        if tmp < 0 { tmp = views.count - 1 }
                        viewIndex = tmp
                    }
                }
        }
        .background(.black)
    }
}
