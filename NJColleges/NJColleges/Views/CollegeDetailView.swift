//
//  CollegeDetailView.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/21/26.
//

import CoreLocation
import MapKit
import SwiftUI

struct CollegeDetailView: View {

    @State private var locationManager = CLLocationManager()
    let college: College

    var collegeInfo: some View {
        let rows: [(String, String)] = [
            ("Name: ", college.properties.name),
            ("City: ", college.properties.city),
            ("County: ", college.properties.county),
            ("Doctoral Program: ", college.properties.doctoral)
        ]
        
        return LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ],
            alignment: .leading
        ) {
            ForEach(rows, id: \.0) {
                row in Text(row.0).fontWeight(.bold)
                Text(row.1)
            }
            .padding()
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView {
                    collegeInfo
                }
                .frame(height: geometry.size.height / 2)

                Map(
                    initialPosition: .region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: college.latitude,
                                longitude: college.longitude
                            ),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                        )
                    )
                ) {
                    UserAnnotation()
                    Marker(
                        college.properties.name,
                        coordinate: CLLocationCoordinate2D(
                            latitude: college.latitude,
                            longitude: college.longitude
                        )
                    )
                }
                .mapControls {
                    MapUserLocationButton()
                }
                .mapStyle(.hybrid(elevation: .realistic))
                .frame(height: geometry.size.height / 2)
            }
            .navigationTitle(college.properties.name)
        }
    }

}

#Preview {
    let vm = CollegeViewModel()
    let college = vm.njColleges[0]
    CollegeDetailView(college: college)
}
