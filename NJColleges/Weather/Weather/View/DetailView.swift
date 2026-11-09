//
//  DetailView.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import SwiftUI

struct DetailView: View {
    @State private var wvm = WeatherViewModel()
    @State private var selected: CLLocationCoordinate2D?
    
    var body: some View {
        VStack {
            ZStack{
                let title = "Weather"
            }
            
            Text("Current Weather:")
                .bold()
            
            Text("Temperature: " + String((wvm.data?.current.temperature)!))
            
        }
    }
}
