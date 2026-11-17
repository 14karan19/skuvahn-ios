//
//  AddressesModels.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import Foundation

struct AddressesResponse: Codable {

    let success: Bool
    let statusCode: Int
    let message: String?
    let messages: [String]?
    let errors: [String: [String]]?
    let data: [BookingAddresses]?
}

struct AddAddressRequest: Codable {

    let addressType: String
    let latitude: String
    let longitude: String
    let locality: String
    let city: String
    let state: String
    let fullAddress: String
    let landmark: String?
    let pincode: String
    let userId: String
}
