//
//  ModelStructs.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/16/26.
//

import Foundation

struct Properties: Codable {
    let id: Int
    let name: String
    let city: String
    let county: String
    let doctoral: String

    enum CodingKeys: String, CodingKey {
        case id = "OBJECTID"
        case name = "Name"
        case city = "Municipali"
        case county = "County"
        case doctoral = "DOCTORAL"
    }

}

struct Geometry: Codable {
    let coordinates: [Double]
}

struct College: Codable, Identifiable {
    let id: Int
    let properties: Properties
    let geometry: Geometry

    var longitude: Double { geometry.coordinates[0] }
    var latitude: Double { geometry.coordinates[1] }

}
