//
//  WeatherModel.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import Foundation
import MapKit
import SwiftUI

//class WeatherModel {
//    var searchString: String = wvm.searchString
//    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
//    var geocoder: Geocoder = Geocoder()
//
//    
//    
//    init(wvm: WeatherViewModel) async {
//        self.searchString = wvm.searchString
//        
//        searchString =
//        do {
//            let coordinates = try await Geocoder.getCoordinates(forAddress: searchString)
//            print(coordinates!)
//        } catch GeocodingError.noLocationFound {
//            print("No Location Found")
//        } catch GeocodingError.invalidZipCode {
//            print("Invalid Zip Code")
//        } catch {
//            print("Unexpected Error")
//        }
//
//        Task {
//            do {
//                let weatherData: [CurrentWeather] = try await getWeatherData(
//                    coordinates: coordinates
//                )
//                for wd in weatherData {
//                    print(wd)
//                }
//            } catch NetworkError.invalidURL {
//                print("The URL provided was invalid.")
//            } catch NetworkError.invalidResponse {
//                print("Server returned an invalid status code.")
//            } catch {
//                print(
//                    "An unexpected error occurred: \(error.localizedDescription)"
//                )
//            }
//        }
//    }

class WeatherModel {
    var searchString: String = ""
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var geocoder = Geocoder()
    func getWeatherData(coordinates: CLLocationCoordinate2D) async throws -> [CurrentWeather] {
        let lat = String(coordinates.latitude)
        let long = String(coordinates.longitude)
        guard
            let url = URL(
                string:
                    "https://api.open-meteo.com/v1/forecast?temperature_unit=fahrenheit&latitude=" + lat + "&longitude=" + long + "&daily=temperature_2m_max,temperature_2m_min") else { throw NetworkError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { throw NetworkError.invalidResponse }
        
        let decoder = JSONDecoder()
        let weatherData = try decoder.decode([CurrentWeather].self, from: data)
        
        return weatherData
    }
}
