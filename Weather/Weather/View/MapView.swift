//
//  MapView.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import CoreLocation
import MapKit
import SwiftUI

struct MapView: View {
    @State private var wvm = WeatherViewModel()
    @State private var locationManager = CLLocationManager()
    @State private var position: MapCameraPosition = .userLocation(
        fallback: .automatic
    )

    var body: some View {
        MapReader { proxy in
            Map(position: $position) {
                if let coordinate = wvm.coordinates {
                    Marker("Location", coordinate: coordinate)
                    UserAnnotation()
                }
            }
            .overlay(alignment: .top) {
                VStack(spacing: 10) {
                    SearchView(wvm: wvm, position: $position)
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 10) {
                            TempView(temperature: wvm.data?.current.temperature)
                            
                            NavigationLink {
                                DetailView(wvm: wvm)
                            } label: {
                                DetailButtonView()
                            }
                            .buttonStyle(.plain)
                            .disabled(wvm.data == nil)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            .toolbar(.hidden, for: .navigationBar)
            .onTapGesture { screenCoord in
                if let coordinate = proxy.convert(screenCoord, from: .local) {
                    Task { await wvm.select(coordinate) }
                }
            }
            .task {
                locationManager.requestWhenInUseAuthorization()
                
                do {
                    for try await update in CLLocationUpdate.liveUpdates() {
                        if let location = update.location {
                            await wvm.useCurrentLocation(location.coordinate)
                            break
                        }
                    }
                } catch {
                    print("Error in setting user's location: \(error)")
                }
            }
        }
    }
}
