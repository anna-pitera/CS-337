//
//  ContentView.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/16/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Summary", systemImage: "book") {
                CollegeSummaryView()
            }
            Tab ("Colleges", systemImage: "tree") {
                CollegeListView()
            }
            Tab ("Map", systemImage: "mappin.and.ellipse") {
                MapView()
            }
        }
    }
}

#Preview {
    ContentView()
}
