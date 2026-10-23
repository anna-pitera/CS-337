//
//  CollegeViewModel.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/22/26.
//

import Observation

@Observable

class CollegeViewModel {
    private let collegeModel = CollegeModel()
    
    var njColleges: [College] = []
    
    init() {
        njColleges = collegeModel.getColleges()
    }
}
