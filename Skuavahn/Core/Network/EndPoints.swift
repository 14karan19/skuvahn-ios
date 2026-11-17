//
//  EndPoints.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

enum EndPoints {

    static let baseURL = "https://api.skuvahn.com/api/v1/"

    static let sendOtp = "auth/sendOtp"

    static let resendOtp = "auth/resendOtp"

    static let verifyOtp = "auth/verifyOtp"
    
    static let saveGuardian = "users/saveGuardian"
    
    static let addresses = "mobile/addresses"
    
    static let deleteAddress = "mobile/deleteAddress"
    
    static let children = "mobile/children"
    
    static let deleteChildren = "mobile/deleteChildren"
    
    static let updateChild = "mobile/children/{id}"
    
    static let bookings = "mobile/bookings"
    
    static let routes = "mobile/routes"
    
    static let schools = "mobile/schools"
    
    static let home = "mobile/home"
    
    static let deleteUser = "users/deleteUser"
}
