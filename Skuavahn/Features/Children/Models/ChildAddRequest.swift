//
//  ChildAddRequest.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

struct ChildAddRequest: Codable {

    let fullName: String
    let dob: String
    let grade: String

    let studentClass: String

    let section: String
    let schoolId: String
    let imageUrl: String

    let emergencyContactName: String
    let emergencyContactPhone: String

    let userId: String

    enum CodingKeys: String, CodingKey {

        case fullName
        case dob
        case grade
        case studentClass = "class"
        case section
        case schoolId
        case imageUrl
        case emergencyContactName
        case emergencyContactPhone
        case userId
    }
}

struct ChildUpdateRequest: Codable {

    let id: String

    let fullName: String
    let dob: String
    let grade: String

    let studentClass: String

    let section: String
    let schoolId: String
    let imageUrl: String

    let emergencyContactName: String
    let emergencyContactPhone: String

    let userId: String

    enum CodingKeys: String, CodingKey {

        case id
        case fullName
        case dob
        case grade
        case studentClass = "class"
        case section
        case schoolId
        case imageUrl
        case emergencyContactName
        case emergencyContactPhone
        case userId
    }
}
