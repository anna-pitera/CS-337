//
//  SearchView.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//
import SwiftUI
import MapKit

struct SearchView: View {
    @State private var wvm = WeatherViewModel()
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField("Search for a location...", text: $wvm.searchString)
                .submitLabel(.search)
                .onSubmit {
                    Task { await search() }
                }
        }
        .padding(12)
        .background(in: RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 4)
    }
    
    private func search() async {
        await wvm.handleSearchSubmit()
        
        if wvm.wm.coordinates.latitude != 0 || wvm.wm.coordinates.longitude != 0 {
            position = .region(MKCoordinateRegion(center: wvm.wm.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        }
    }
}
