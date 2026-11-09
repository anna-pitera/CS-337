//
//  ContentView.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import SwiftUI

struct ContentView: View {
    @State var wvm: WeatherViewModel
    var weatherModel: WeatherModel
        
    init() async {
        let initialWVM = WeatherViewModel()
        self.wvm = initialWVM
        self.weatherModel = WeatherModel()
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear { // this for testing the geocoder only
            Task {
                let myLocation = try await Geocoder.getCoordinates(forAddress: "100 Ocean Ave, Long Branch, NJ")
                print (myLocation ?? "No Location")
                let myData = wvm.searchString
                print(myData)
            }
        }
//        TabView {
//            Tab("Home", systemImage: "book") {
//                HomeView()
//            }
//        }
    }
}

#Preview {
    ContentView()
}
