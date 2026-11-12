//
//  TempView.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/6/26.
//
import SwiftUI

struct TempView: View {
    let temperature: Double?
    
    var body: some View {
        Text(temperature.map { "\(Int($0.rounded()))°" } ?? "--°")
            .font(.title2.weight(.bold))
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(in: RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 4)
    }
}
