//
//  RouteAPI.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

final class RouteAPI {

    static let shared = RouteAPI()

    private init() {}

    func getRoutes()
    async throws
    -> BaseResponse<[BookingsRoute]> {

        try await NetworkManager.shared.get(
            endpoint:
            EndPoints.baseURL +
            EndPoints.routes,

            token:
            AppPref.shared.token,

            responseType:
            BaseResponse<[BookingsRoute]>.self
        )
    }
}
