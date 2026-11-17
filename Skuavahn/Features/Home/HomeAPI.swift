//
//  HomeAPI.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

extension AuthAPI {

    func getHome() async throws -> HomeResponseModel {

        let url =
        URL(
            string:
            "\(EndPoints.baseURL)\(EndPoints.home)?userId=\(AppPref.shared.userId)"
        )!

        var request =
        URLRequest(url: url)

        request.httpMethod = "GET"

        request.addValue(
            AppPref.shared.token,
            forHTTPHeaderField: "Authorization"
        )

        let (data, _) =
        try await URLSession.shared.data(
            for: request
        )

        return try JSONDecoder()
            .decode(
                HomeResponseModel.self,
                from: data
            )
    }
}
