//
//  AuthAPI.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

final class AuthAPI {

    static let shared = AuthAPI()

    private init() {}

    func sendOtp(
        phone: String
    ) async throws
    -> BaseResponse<SendOtpResponse> {

        try await NetworkManager.shared.post(
            endpoint:
                EndPoints.baseURL +
                EndPoints.sendOtp,

            body:
                SendOtpRequest(
                    phone: phone
                ),

            responseType:
                BaseResponse<SendOtpResponse>.self
        )
    }

    func resendOtp(
        phone: String
    ) async throws
    -> BaseResponse<Bool> {

        try await NetworkManager.shared.post(
            endpoint:
                EndPoints.baseURL +
                EndPoints.resendOtp,

            body:
                ResendOtpRequest(
                    phone: phone
                ),

            responseType:
                BaseResponse<Bool>.self
        )
    }

    func verifyOtp(
        phone: String,
        otp: String
    ) async throws
    -> BaseResponse<VerifyOtpResponse> {

        try await NetworkManager.shared.post(
            endpoint:
                EndPoints.baseURL +
                EndPoints.verifyOtp,

            body:
                VerifyOtpRequest(
                    phone: phone,
                    otp: otp
                ),

            responseType:
                BaseResponse<VerifyOtpResponse>.self
        )
    }
    
    func deleteUser(request: DeleteUserRequest,
                    token: String) async throws -> DeleteUserResponse {

        let url = URL(
            string: "\(EndPoints.baseURL)\(EndPoints.deleteUser)"
        )!

        let request =
        DeleteUserRequest(
            userId: AppPref.shared.userId
        )
        
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "POST"

        urlRequest.addValue(
            AppPref.shared.token,
            forHTTPHeaderField: "Authorization"
        )

        urlRequest.addValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        urlRequest.httpBody = try JSONEncoder().encode(request)

        let (data, _) = try await URLSession.shared.data(
            for: urlRequest
        )

        return try JSONDecoder().decode(
            DeleteUserResponse.self,
            from: data
        )
    }
}
