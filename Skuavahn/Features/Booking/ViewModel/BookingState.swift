//
//  BookingState.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//


import Foundation

enum BookingState {

    case idle

    case loading

    case success([Boooking])

    case createSuccess(String)

    case dropdownData

    case error(String)
}
