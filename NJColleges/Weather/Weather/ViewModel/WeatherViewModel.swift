//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import Foundation
import _LocationEssentials

class WeatherViewModel: Observable {
    var searchString: String = ""
    var data: WeatherData?
    
    let wm = WeatherModel()
    
    func handleSearchSubmit() async {
        wm.searchString = searchString
        
        do {
            guard let coords = try await Geocoder.getCoordinates(forAddress: wm.searchString) else {
                print("Invalid location")
                return
            }
            wm.coordinates = coords
            
            print("Coordinates: " + String(coords.latitude) + ", " + String(coords.longitude))
            
            let data = try await wm.getForecastData(coordinates: coords)
            
            for day in data.forecast.days {
                print(day)
            }
        }
        catch {
            print("Error: \(error)")
        }
    }
}
