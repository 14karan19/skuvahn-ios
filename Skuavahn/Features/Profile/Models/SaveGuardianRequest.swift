//
//  SaveGuardianRequest.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

struct SaveGuardianRequest: Codable {

    let userId: String
    let fullName: String
    let phone: String
    let email: String?
    let imageUrl: String
}
