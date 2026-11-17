//
//  AddressModels.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

struct AddressResponse: Codable {

    let success: Bool
    let statusCode: Int
    let message: String?
    let messages: [String]?
    let errors: [String: [String]]?
    let data: [BookingAddresses]?
}

struct BookingAddresses: Codable, Identifiable, Hashable {

    let id: String?

    let latitude: String?

    let longitude: String?

    let locality: String?

    let fullAddress: String?

    let pincode: String?

    let landmark: String?

    let addressType: String?

    var addressTitle: String {

        addressType ?? ""
    }

    var address: String {

        fullAddress ?? ""
    }

    var city: String {

        locality ?? ""
    }

    var pinCode: String {

        pincode ?? ""
    }
}
