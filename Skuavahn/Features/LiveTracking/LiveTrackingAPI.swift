//
//  LiveTrackingAPI.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import Foundation

final class LiveTrackingAPI {

    static let shared =
    LiveTrackingAPI()

    private init() {}

    func getLiveLocation(
        terminalNo: String,
        key: String
    ) async throws -> LiveTrackingResponse {

        let request =
        LiveTrackingRequest(
            queryParams: [terminalNo]
        )

        let url =
        URL(
            string:
            "https://y.gpstracktech.com/api/monitor/getRealTimeInfo"
        )!

        var urlRequest =
        URLRequest(url: url)

        urlRequest.httpMethod = "POST"

        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField:
            "Content-Type"
        )

        urlRequest.setValue(
            "1.0",
            forHTTPHeaderField:
            "version"
        )

        urlRequest.setValue(
            "en",
            forHTTPHeaderField:
            "Accept-Language"
        )

        urlRequest.setValue(
            key,
            forHTTPHeaderField:
            "key"
        )

        urlRequest.httpBody =
        try JSONEncoder()
            .encode(request)

        let (data, _) =
        try await URLSession.shared
            .data(
                for: urlRequest
            )

        return try JSONDecoder()
            .decode(
                LiveTrackingResponse.self,
                from: data
            )
    }
}
