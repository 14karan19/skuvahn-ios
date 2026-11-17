//
//  AuthState.swift
//  Skuavahn
//
//  Created by Karan Lamba on 02/06/26.
//

import Foundation

enum AuthState: Equatable {

    case idle

    case loading

    case otpSent(
        userId: String,
        phone: String,
        isNewUser: Bool
    )

    case codeSent

    case verified(
        accessToken: String,
        isProfileComplete: Bool
    )

    case error(String)
}
