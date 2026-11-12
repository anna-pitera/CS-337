//
//  DetailButtonView.swift
//  Weather
//
//  Created by Anna R. Pitera on 11/9/26.
//

import SwiftUI

struct DetailButtonView: View {
    var body: some View {
        Image(systemName: "ellipsis.calendar")
            .font(.title2.weight(.bold))
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(in: RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 4)
    }
}
