//
//  ProfileAPI.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

extension AuthAPI {

    func saveGuardian(
        request: SaveGuardianRequest,
        token: String
    ) async throws -> SaveGuardianResponse {

        let url =
        URL(
            string:
            "\(EndPoints.baseURL)\(EndPoints.saveGuardian)"
        )!

        var urlRequest =
        URLRequest(url: url)

        urlRequest.httpMethod = "POST"

        urlRequest.addValue(
            token,
            forHTTPHeaderField:
                "Authorization"
        )

        urlRequest.addValue(
            "application/json",
            forHTTPHeaderField:
                "Content-Type"
        )

        urlRequest.httpBody =
        try JSONEncoder().encode(request)

        let (data, _) =
        try await URLSession.shared.data(
            for: urlRequest
        )

        return try JSONDecoder()
            .decode(
                SaveGuardianResponse.self,
                from: data
            )
    }
}
