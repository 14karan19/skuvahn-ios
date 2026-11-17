//
//  SaveGuardianResponse.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

struct SaveGuardianResponse: Codable {

    let success: Bool
    let statusCode: Int
    let message: String?
    let messages: [String]?
    let errors: String?
    let data: GuardianData?
}

struct GuardianData: Codable {

    let userId: String?
    let isProfileCompleted: Bool?
}
