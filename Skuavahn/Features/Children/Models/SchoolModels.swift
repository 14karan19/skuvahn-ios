//
//  SchoolModels.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

struct SchoolResponseModel: Codable {

    let success: Bool
    let message: String?
    let data: [Schoool]?
}

struct Schoool: Codable, Identifiable, Hashable {

    let id: String
    let name: String
}
