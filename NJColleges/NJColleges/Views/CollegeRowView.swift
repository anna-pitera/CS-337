//
//  CollegeRow.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/21/26.
//

import SwiftUI

struct CollegeRowView: View {
    let college: College
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(college.properties.name)
                .font(.headline)
            HStack {
                Text(college.properties.city)
                Spacer()
                Text(college.properties.county)
            }
        }
        .padding()
    }
}
