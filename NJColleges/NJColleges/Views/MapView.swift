//
//  MapView.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/21/26.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var locationManager = CLLocationManager()
    @State var collegeVM = CollegeViewModel()
    @State var selectedCollege: College?

    var body: some View {
        Map {
            UserAnnotation()
            ForEach(collegeVM.njColleges) { college in
                Annotation(
                    college.properties.city,
                    coordinate: CLLocationCoordinate2D(
                        latitude: college.latitude,
                        longitude: college.longitude
                    )
                ) {
                    Image(systemName: "graduationcap.circle.fill")
                        .opacity(0.9)
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .onTapGesture { selectedCollege = college }
                }
            }
        }
        .sheet(item: $selectedCollege) { college in
            CollegeDetailView(college: college)
             .presentationDetents([.medium, .large])
             .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    MapView()
}
