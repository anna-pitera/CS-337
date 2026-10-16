//
//  ContentView.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/16/26.
//

import SwiftUI

struct ContentView: View {
    let model = CollegeModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
