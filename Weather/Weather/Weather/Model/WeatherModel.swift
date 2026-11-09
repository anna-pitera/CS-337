//
//  WeatherModel.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import Foundation
import MapKit

class WeatherModel {
    var searchString: String = ""
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var geocoder = Geocoder()
    
    func getForecastData(coordinates: CLLocationCoordinate2D) async throws -> WeatherData {
        let lat = String(coordinates.latitude)
        let long = String(coordinates.longitude)
        
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?temperature_unit=fahrenheit&latitude=\(lat)&longitude=\(long)&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min") else { throw NetworkError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { throw NetworkError.invalidResponse }
        
        let decoded = try JSONDecoder().decode(APIResponse.self, from: data)
        
        let currentFormatter = DateFormatter()
        currentFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        currentFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd"
        dayFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let current = CurrentWeather(
            date: currentFormatter.date(from: decoded.current.time) ?? Date(),
            temperature: decoded.current.temperature_2m
        )
        
        var days: [DailyForecast] = []
        for i in decoded.daily.time.indices {
            guard let date = dayFormatter.date(from: decoded.daily.time[i]) else { continue }
            days.append(DailyForecast(date: date, highTemp: decoded.daily.temperature_2m_max[i], lowTemp: decoded.daily.temperature_2m_min[i]))
        }
        
        return WeatherData(current: current, forecast: Forecast(days: days))
        
    }
}
