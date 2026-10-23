//
//  ListView.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/21/26.
//

import SwiftUI

struct CollegeListView: View {
    @State var collegesVM = CollegeModel()
    @State var searchText: String = ""

    var body: some View {
        NavigationStack {
            List(searchResults) { college in
                NavigationLink(
                    destination:
                        CollegeDetailView(college: college)
                ) { CollegeRowView(college: college) }
            }
        }
        .navigationTitle("Colleges")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText)
    }

    var searchResults: [College] {
        if searchText.isEmpty {
            return collegesVM.njColleges
        } else {
            return collegesVM.njColleges.filter { (searchFilter(college: $0)) }
        }
    }
    
    func searchFilter(college: College) -> Bool {
        return college.properties.name.lowercased().contains(searchText.lowercased()) || college.properties.city.lowercased().contains(searchText.lowercased()) || college.properties.county.lowercased().contains(searchText.lowercased())
    }

}

#Preview {
    CollegeListView()
}
