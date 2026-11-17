//
//  AddressesAPI.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import Foundation

final class AddressesAPI {

    static let shared = AddressesAPI()

    private init() { }

    func getAddresses(
        userId: String
    ) async throws -> AddressesResponse {

        try await NetworkManager.shared.get(
            endpoint:
            EndPoints.baseURL +
            "\(EndPoints.addresses)?userId=\(userId)",

            token:
            AppPref.shared.token,

            responseType:
                AddressesResponse.self
        )
    }

    func addAddress(
        request: AddAddressRequest
    ) async throws -> BaseResponse<String> {

        try await NetworkManager.shared.post(
            endpoint:
            EndPoints.baseURL +
            EndPoints.addresses,

            token:
            AppPref.shared.token,

            body:
            request,

            responseType:
            BaseResponse<String>.self
        )
    }

    func deleteAddress(
        addressId: String,
        userId: String
    ) async throws -> BaseResponse<Bool> {

        try await NetworkManager.shared.delete(
            endpoint:
            EndPoints.baseURL +
                "\(EndPoints.deleteAddress)/\(addressId)?userId=\(userId)",
            
            token:
            AppPref.shared.token,

            responseType:
            BaseResponse<Bool>.self
        )
    }
}
