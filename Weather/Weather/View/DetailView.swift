//
//  DetailView.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//

import SwiftUI

struct DetailView: View {
    let wvm: WeatherViewModel

    var body: some View {
        List {
            if let data = wvm.data {
                Section("Now") {
                    VStack(alignment: .leading, spacing: 4) {
                        if let place = wvm.placeName {
                            Label(place, systemImage: "location.fill")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Text("\(Int(data.current.temperature.rounded()))°")
                            .font(.largeTitle.bold())
                    }
                    HStack {
                        Label("Wind", systemImage: "wind")
                        Spacer()
                        Text("\(Int(data.current.windSpeed.rounded())) mph")
                            .foregroundStyle(.secondary)
                            .monospacedDigit()
                    }
                }

                Section("This Week") {
                    forecastTable(data.forecast.days)
                }
            } else {
                Text("Enter a location to see forecast data.")
            }
        }
        .navigationTitle("Weather")
    }

    private func forecastTable(_ days: [DailyForecast]) -> some View {
        Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 10) {
            GridRow {
                Text("Date")
                Text("Low").gridColumnAlignment(.trailing)
                Text("High").gridColumnAlignment(.trailing)
            }
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.secondary)

            Divider()

            ForEach(days) { day in
                GridRow {
                    HStack(spacing: 6) {
                        Text(day.date, format: .dateTime.weekday(.abbreviated))
                            .frame(width: 36, alignment: .leading)
                        Text(
                            day.date,
                            format: .dateTime.month(.defaultDigits).day()
                        )
                        .foregroundStyle(.secondary)
                    }
                    Text("\(Int(day.lowTemp.rounded()))°")
                    Text("\(Int(day.highTemp.rounded()))°")
                }
                .monospacedDigit()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(wvm: WeatherViewModel())
    }
}
