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
    @State public var selected: CLLocationCoordinate2D?

    var body: some View {
        MapReader { proxy in
            Map(position: $position) {
                if wvm.wm.coordinates.latitude != 0 {
                    Marker("Location", coordinate: wvm.wm.coordinates)
                }
            }
                .overlay(alignment: .top) {
                    VStack(spacing: 10) {
                        SearchView()

                        HStack {
                            Spacer()
                            TempView(temperature: wvm.data?.current.temperature)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
                .onTapGesture { screenCoord in
                    if let coordinate = proxy.convert(screenCoord, from: .local)
                    {
                        selected = coordinate
                    }
                }
                .onAppear {
                    locationManager.requestWhenInUseAuthorization()
                }
        }
    }
}
