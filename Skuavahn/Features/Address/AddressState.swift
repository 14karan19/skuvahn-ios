//
//  AddressState.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import Foundation

enum AddressState: Equatable{

    case idle

    case loading

    case success([BookingAddresses])

    case addSuccess(String)

    case deleteSuccess(String)

    case error(String)
}
