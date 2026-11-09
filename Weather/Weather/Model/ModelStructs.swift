//
//  CurrentWeather.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import MapKit

//struct WeekWeather: Codable, Hashable {
//    let week: [Date]
//    
//    enum CodingKeys: String, CodingKey {
//        case week: 
//    }
//}

struct CurrentWeather: Codable {
    var date: Date
    var highTemp: Double
    var lowTemp: Double
}
