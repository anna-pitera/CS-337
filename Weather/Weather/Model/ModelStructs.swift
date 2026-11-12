//
//  ModelStructs.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import MapKit

struct CurrentWeather {
    var date: Date
    var temperature: Double
    var windSpeed: Double
}

struct DailyForecast: Identifiable {
    var id: Date { date }
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
    let current: Current
    let daily: Daily
    
    struct Current: Decodable {
        let time: String
        let temperature_2m: Double
        let wind_speed_10m: Double
    }
    
    struct Daily: Decodable {
        let time: [String]
        let temperature_2m_max: [Double]
        let temperature_2m_min: [Double]
    }
}
