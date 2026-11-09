//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    var searchString: String = ""
    
    let wm = WeatherModel()
    
    func handleSearchSubmit() async {
        // 1. Pass the string to your separate class *only* on submission
        wm.searchString = self.searchString
        
        // 2. Tell the model to perform its action
        let location = try await Geocoder.getCoordinates(forAddress: wm.searchString)
    }
}
