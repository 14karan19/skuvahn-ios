//
//  HomeResponseModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

struct HomeResponseModel: Codable {

    let success: Bool
    let statusCode: Int
    let message: String?
    let data: HomeData?
}

struct HomeData: Codable {

    let user: HomeUser?
    let banners: [Banner]?
    let activeBookings: [Booking]?
}

struct HomeUser: Codable {

    let id: String
    let fullName: String
    let phone: String
    let email: String?
    let imageUrl: String?
}

struct Banner: Codable, Identifiable {

    let id: String
    let bannerUrl: String
}
