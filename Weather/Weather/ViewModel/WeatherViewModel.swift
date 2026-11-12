//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import Foundation
import Observation
import CoreLocation

@MainActor
@Observable
class WeatherViewModel {
    var searchString: String = ""
    var data: WeatherData?
    var coordinates: CLLocationCoordinate2D?
    var placeName: String?
    
    private let wm = WeatherModel()
    private var hasSelectedLocation = false
    
    // called when the user submits entry in search field
    func handleSearchSubmit() async {
        do {
            guard let coords = try await Geocoder.getCoordinates(forAddress: searchString) else {
                print("Invalid location")
                return // if the user's searchString is invalid, the search text is not reset - this gives the user room to fix any typos
            }
            
            // reset search text after entry - this only happens if the user enters a valid searchString
            searchString = ""
            
            await select(coords)
        }
        catch {
            print("\(error)")
        }
    }
    
    func select(_ coords: CLLocationCoordinate2D) async {
        hasSelectedLocation = true
        coordinates = coords
        
        async let name = Geocoder.getPlaceName(forCoordinate: coords)
        
        do {
            data = try await wm.getForecastData(coordinates: coords)
        } catch {
            print("\(error)")
        }
        
        placeName = await name
    }
    
    func useCurrentLocation(_ coords: CLLocationCoordinate2D) async {
        guard !hasSelectedLocation else { return }
        
        async let name = Geocoder.getPlaceName(forCoordinate: coords)
        
        do {
            let result = try await wm.getForecastData(coordinates: coords)
            let resolvedName = await name
            guard !hasSelectedLocation else { return }
            data = result
            placeName = resolvedName
        } catch {
            print("\(error)")
        }
    }
}
