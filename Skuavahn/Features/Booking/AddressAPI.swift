//
//  AddressAPI.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

final class AddressAPI {

    static let shared = AddressAPI()

    private init() {}

    func getAddresses(
        userId: String
    ) async throws
    -> BaseResponse<[BookingAddresses]> {

        try await NetworkManager.shared.get(
            endpoint:
            EndPoints.baseURL +
            "\(EndPoints.addresses)?userId=\(userId)",

            token:
            AppPref.shared.token,

            responseType:
            BaseResponse<[BookingAddresses]>.self
        )
    }
}
