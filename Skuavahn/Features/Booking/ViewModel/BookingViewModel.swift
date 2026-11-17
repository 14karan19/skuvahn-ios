//
//  BookingViewModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import SwiftUI
import Combine

@MainActor
final class BookingViewModel:
ObservableObject {

    @Published var state:
    BookingState = .idle

    @Published var bookings:
    [Boooking] = []

    @Published var children:
    [Children] = []

    @Published var addresses:
    [BookingAddresses] = []

    @Published var schools:
    [Schoool] = []

    @Published var routes:
    [BookingsRoute] = []

    // MARK: Get Bookings

    func getBookings() {

        Task {

            do {

                state = .loading

                let response =
                try await BookingAPI.shared
                    .getBookings(
                        userId:
                        AppPref.shared.userId
                    )

                let list =
                response.data ?? []

                bookings = list

                state =
                .success(list)

            } catch {

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }

    // MARK: Load Dropdowns

    func loadDropdowns() {

        Task {

            do {

                state = .loading

                async let childResponse =
                ChildAPI.shared.getChildren(
                    userId:
                    AppPref.shared.userId
                )

                async let addressResponse =
                AddressAPI.shared.getAddresses(
                    userId:
                    AppPref.shared.userId
                )

                async let schoolResponse =
                ChildAPI.shared.getSchools()

                async let routeResponse =
                RouteAPI.shared.getRoutes()

                children =
                try await childResponse.data ?? []

                addresses =
                try await addressResponse.data ?? []

                schools =
                try await schoolResponse.data ?? []

                routes =
                try await routeResponse.data ?? []

                state =
                .dropdownData

            } catch {

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }

    // MARK: Create Booking

    func createBooking(
        childId: String,
        addressId: String,
        schoolId: String,
        tenure: String,
        startDate: String
    ) {

        Task {

            do {

                state = .loading

                let request =
                BookingCreateRequest(
                    childId:
                    childId,

                    addressId:
                    addressId,

                    schoolId:
                    schoolId,

                    tenure:
                    tenure,

                    startDate:
                    startDate,

                    userId:
                    AppPref.shared.userId
                )

                let response =
                try await BookingAPI.shared
                    .createBooking(
                        request:
                        request
                    )

                if response.success {

                    state =
                    .createSuccess(
                        response.message ??
                        "Booking created successfully"
                    )

                } else {

                    state =
                    .error(
                        response.message ??
                        "Unable to create booking"
                    )
                }

            } catch {

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }
}
