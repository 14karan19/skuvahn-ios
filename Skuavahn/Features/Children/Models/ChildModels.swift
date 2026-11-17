//
//  ChildModels.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation
import Combine

// MARK: - Get Children Response

struct ChildResponseModel: Codable {

    let success: Bool
    let statusCode: Int
    let message: String?
    let messages: [String]?
    let errors: [String: [String]]?
    let data: [Children]?
}

// MARK: - Child

struct Children: Codable, Identifiable, Hashable {

    let id: String?
    let fullName: String?
    let dob: String?
    let grade: String?

    let studentClass: String?

    let section: String?
    let schoolId: String?
    let schoolName: String?
    let imageUrl: String?

    let emergencyContactName: String?
    let emergencyContactPhone: String?

    enum CodingKeys: String, CodingKey {

        case id
        case fullName
        case dob
        case grade
        case studentClass = "class"
        case section
        case schoolId
        case schoolName
        case imageUrl
        case emergencyContactName
        case emergencyContactPhone
    }
}

// MARK: - Helpers

extension Children {

    var formattedDob: String {

        guard let dob else {
            return ""
        }

        let inputFormatter =
        ISO8601DateFormatter()

        if let date =
            inputFormatter.date(
                from: dob
            ) {

            let outputFormatter =
            DateFormatter()

            outputFormatter.dateFormat =
            "dd-MM-yyyy"

            return outputFormatter.string(
                from: date
            )
        }

        return dob
    }
}
