//
//  BookingAPI.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

final class BookingAPI {

    static let shared = BookingAPI()

    private init() {}

    // MARK: Get Bookings

    func getBookings(
        userId: String
    ) async throws
    -> BaseResponse<[Boooking]> {

        try await NetworkManager.shared.get(
            endpoint:
            EndPoints.baseURL +
            "\(EndPoints.bookings)?userId=\(userId)",

            token:
            AppPref.shared.token,

            responseType:
            BaseResponse<[Boooking]>.self
        )
    }

    // MARK: Create Booking

    func createBooking(
        request: BookingCreateRequest
    ) async throws
    -> BaseResponse<String> {

        try await NetworkManager.shared.post(
            endpoint:
            EndPoints.baseURL +
            EndPoints.bookings,

            token:
            AppPref.shared.token,

            body:
            request,

            responseType:
            BaseResponse<String>.self
        )
    }
}
