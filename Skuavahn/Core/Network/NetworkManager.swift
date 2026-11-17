//
//  NetworkManager.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

final class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    // MARK: GET

    func get<U: Codable>(
        endpoint: String,
        token: String? = nil,
        responseType: U.Type
    ) async throws -> U {

        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        if let token,
           !token.isEmpty {

            request.setValue(
                "\(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        printRequest(request)

        let (data, response) =
        try await URLSession.shared.data(
            for: request
        )

        printResponse(
            data: data,
            response: response
        )

        try validate(
            response,
            data: data
        )

        do {

            return try JSONDecoder()
                .decode(
                    U.self,
                    from: data
                )

        } catch {

            print("❌ DECODING ERROR")
            print(error)

            if let json =
                String(
                    data: data,
                    encoding: .utf8
                ) {

                print(json)
            }

            throw error
        }
    }

    // MARK: POST

    func post<T: Codable, U: Codable>(
        endpoint: String,
        token: String? = nil,
        body: T,
        responseType: U.Type
    ) async throws -> U {

        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        if let token,
           !token.isEmpty {

            request.setValue(
                "\(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        request.httpBody =
        try JSONEncoder()
            .encode(body)

        printRequest(request)

        let (data, response) =
        try await URLSession.shared.data(
            for: request
        )

        printResponse(
            data: data,
            response: response
        )

        try validate(
            response,
            data: data
        )

        do {

            return try JSONDecoder()
                .decode(
                    U.self,
                    from: data
                )

        } catch {

            print("❌ DECODING ERROR")
            print(error)

            if let json =
                String(
                    data: data,
                    encoding: .utf8
                ) {

                print(json)
            }

            throw error
        }
    }

    // MARK: PUT

    func put<T: Codable, U: Codable>(
        endpoint: String,
        token: String? = nil,
        body: T,
        responseType: U.Type
    ) async throws -> U {

        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = "PUT"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        if let token,
           !token.isEmpty {

            request.setValue(
                "\(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        request.httpBody =
        try JSONEncoder()
            .encode(body)

        printRequest(request)

        let (data, response) =
        try await URLSession.shared.data(
            for: request
        )

        printResponse(
            data: data,
            response: response
        )

        try validate(
            response,
            data: data
        )

        do {

            return try JSONDecoder()
                .decode(
                    U.self,
                    from: data
                )

        } catch {

            print("❌ DECODING ERROR")
            print(error)

            if let json =
                String(
                    data: data,
                    encoding: .utf8
                ) {

                print(json)
            }

            throw error
        }
    }

    // MARK: DELETE

    func delete<U: Codable>(
        endpoint: String,
        token: String? = nil,
        responseType: U.Type
    ) async throws -> U {

        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        if let token,
           !token.isEmpty {

            request.setValue(
                "\(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        printRequest(request)

        let (data, response) =
        try await URLSession.shared.data(
            for: request
        )

        printResponse(
            data: data,
            response: response
        )

        try validate(
            response,
            data: data
        )

        do {

            return try JSONDecoder()
                .decode(
                    U.self,
                    from: data
                )

        } catch {

            print("❌ DECODING ERROR")
            print(error)

            if let json =
                String(
                    data: data,
                    encoding: .utf8
                ) {

                print(json)
            }

            throw error
        }
    }

    // MARK: Helpers

    private func printRequest(
        _ request: URLRequest
    ) {

        print("\n")
        print("🚀 REQUEST")
        print("URL:", request.url?.absoluteString ?? "")
        print("METHOD:", request.httpMethod ?? "")

        if let auth =
            request.value(
                forHTTPHeaderField:
                    "Authorization"
            ) {

            print("AUTH:", auth)
        }

        print("🚀 REQUEST END")
        print("\n")
    }

    private func printResponse(
        data: Data,
        response: URLResponse
    ) {

        guard let http =
                response
            as? HTTPURLResponse
        else {
            return
        }

        print("\n")
        print("✅ RESPONSE")
        print("STATUS:", http.statusCode)

        if let json =
            String(
                data: data,
                encoding: .utf8
            ) {

            print(json)
        }

        print("✅ RESPONSE END")
        print("\n")
    }

    private func validate(
        _ response: URLResponse,
        data: Data
    ) throws {

        guard let httpResponse =
                response
            as? HTTPURLResponse
        else {

            throw URLError(
                .badServerResponse
            )
        }

        guard
            200...299 ~= httpResponse.statusCode
        else {

            print("❌ HTTP ERROR")
            print("STATUS:", httpResponse.statusCode)

            if let json =
                String(
                    data: data,
                    encoding: .utf8
                ) {

                print(json)
            }

            throw URLError(
                .badServerResponse
            )
        }
    }
}
