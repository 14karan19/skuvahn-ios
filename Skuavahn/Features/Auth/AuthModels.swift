//
//  AuthModels.swift
//  Skuavahn
//
//  Created by Karan Lamba on 02/06/26.
//

import Foundation

// MARK: Requests

struct SendOtpRequest: Codable {

    let phone: String

    let roleType: String =
    "guardian"
}

struct VerifyOtpRequest: Codable {

    let phone: String

    let otp: String

    let roleType: String =
    "guardian"
}

struct ResendOtpRequest: Codable {

    let phone: String
}

// MARK: Responses

struct SendOtpResponse: Codable {

    let userId: String

    let phone: String

    let isNewUser: Bool
}

struct VerifyOtpResponse: Codable {
    let accessToken: String
    let isProfileComplete: Bool
}

// MARK: Base Response

struct BaseResponse<T: Codable>: Codable {

    let success: Bool

    let statusCode: Int

    let message: String?

    let messages: [String]?

    let data: T?
}
