//
//  LiveTrackingModels.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import Foundation

struct LiveTrackingRequest: Codable {

    let queryType: Int
    let queryParams: [String]

    init(queryParams: [String]) {

        self.queryType = 1
        self.queryParams = queryParams
    }
}

struct LiveTrackingResponse: Codable {

    let code: Int
    let data: LiveDataWrapper?
    let msg: String
}

struct LiveDataWrapper: Codable {
    let list: [LiveTrackingVehicle]
}

struct LiveTrackingVehicle: Codable {

    let lat: Double
    let lon: Double
    let speed: Double
    let plate: String
}
