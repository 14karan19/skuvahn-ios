//
//  DeleteUserModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 31/07/26.
//

struct DeleteUserRequest: Codable {
    let userId: String
}

struct DeleteUserResponse: Codable {
    let success: Bool
    let statusCode: Int
    let message: String?
    let messages: [String]?
    let errors: [String: [String]]?
    let data: DeleteUserData?
}

struct DeleteUserData: Codable {
    let userId: String?
}
