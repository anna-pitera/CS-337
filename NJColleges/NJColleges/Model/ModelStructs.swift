//
//  ModelStructs.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/16/26.
//

struct Properties: Codable {
    let name: String
    let city: String
    let county: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case city = "Municipali"
        case county = "County"
    }
    
}

struct Geometry: Codable {
    let coordinates: [Double]
}

struct College: Codable, Identifiable {
    let id: Int
    let properties: Properties
    let geometry: Geometry
    
}
