//
//  Geocoder.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import MapKit

// custom error for handling geocoding failures - provided by starter file
enum GeocodingError: Error {
    case noLocationFound
    case invalidZipCode
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

// converts a postal code string to geographic coordinates using async/await - provided by starter file
// parameter forAddress: String - the address string to look up (ex: "595 Broad Street, Shrewsbury, NJ 07702"
// returns: CLLocationCoordinate2D object (if found)
struct Geocoder {
    static func getCoordinates(forAddress address: String) async throws -> CLLocationCoordinate2D? {
        // let geocoder = CLGeocoder()
        let geoCoderRequest = MKGeocodingRequest(addressString: address)
        let mapItem = try await geoCoderRequest?.mapItems.first?.location
        if let item = mapItem {
            let loc = CLLocationCoordinate2D(latitude: item.coordinate.latitude, longitude: item.coordinate.longitude)
            return loc
        }
        return nil
    }
}
