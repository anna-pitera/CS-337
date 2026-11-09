//
//  CurrentWeather.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import MapKit

struct CurrentWeather {
    var date: Date
    var temperature: Double
}

struct DailyForecast {
    var date: Date
    var highTemp: Double
    var lowTemp: Double
}

struct Forecast {
    var days: [DailyForecast]
}

struct WeatherData {
    var current: CurrentWeather
    var forecast: Forecast
}

struct APIResponse: Decodable {
    let current: CurrentWeather
    let daily: DailyForecast
    
    struct CurrentWeather: Decodable {
        let time: String
        let temperature_2m: Double
    }
    
    struct DailyForecast: Decodable {
        let time: [String]
        let temperature_2m_max: [Double]
        let temperature_2m_min: [Double]
    }
}
