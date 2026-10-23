//
//  CollegeModel.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/16/26.
//
import Foundation

class CollegeModel {
    // initialize empty njColleges collection
    var njColleges: [College] = []

    init() {
        readCollegesData()
    }

    func getColleges() -> [College] {
        return self.njColleges
    }

    func getCollege(collegeId: Int) -> College? {
        if let college = njColleges.first(where: { $0.id == collegeId }) {
            return college
        } else {
            return nil
        }
    }

    func readCollegesData() {
        if let filename = Bundle.main.path(
            forResource: "NJColleges",
            ofType: "json"
        ) {
            do {
                let jsonStr = try String(
                    contentsOfFile: filename,
                    encoding: .utf8
                )
                let jsonData = jsonStr.data(using: .utf8)!

                // decode features
                njColleges = try JSONDecoder().decode(
                    [College].self,
                    from: jsonData
                )
                print(njColleges.count)
                print(njColleges)

            } catch let DecodingError.keyNotFound(key, context) {
                print(
                    "Missing key '\(key.stringValue)' at path: \(codingPathString(context.codingPath))"
                )
                print("Details: \(context.debugDescription)")
            } catch let DecodingError.typeMismatch(type, context) {
                print(
                    "Type mismatch: expected \(type) at path: \(codingPathString(context.codingPath))"
                )
                print("Details: \(context.debugDescription)")
            } catch let DecodingError.valueNotFound(type, context) {
                print(
                    "Null/missing value: expected \(type) at path: \(codingPathString(context.codingPath))"
                )
                print("Details: \(context.debugDescription)")
            } catch let DecodingError.dataCorrupted(context) {
                print(
                    "Data corrupted (invalid JSON?) at path: \(codingPathString(context.codingPath))"
                )
                print("Details: \(context.debugDescription)")
                if let underlying = context.underlyingError {
                    print("Underlying error: \(underlying)")
                }
            } catch let error as CocoaError {
                // error in reading file
                print("File error: \(error.localizedDescription)")
            } catch {
                print("Unexpected error: \(error)")
            }
        } else {
            print("The file could not be found")
        }
    }

    func codingPathString(_ path: [CodingKey]) -> String {
        path.map { $0.intValue.map { "[\($0)]" } ?? ".\($0.stringValue)" }
            .joined()
    }
}
