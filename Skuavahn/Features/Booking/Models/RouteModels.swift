//
//  RouteModels.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

struct RouteResponse: Codable {

    let success: Bool
    let statusCode: Int
    let message: String?
    let messages: [String]?
    let errors: [String: [String]]?
    let data: [BookingsRoute]?
}

struct BookingsRoute: Codable, Identifiable, Hashable {

    let id: String

    let captainId: String?

    let routeStop: String?

    let landmark: String?

    let latitude: String?

    let longitude: String?

    let isActive: Bool?
}
