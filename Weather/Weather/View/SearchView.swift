//
//  SearchView.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//
import SwiftUI
import MapKit

struct SearchView: View {
    @Bindable var wvm: WeatherViewModel
    @Binding var position: MapCameraPosition
    
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
        
        if let coords = wvm.coordinates {
            position = .region(MKCoordinateRegion(center: coords, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        }
    }
}
