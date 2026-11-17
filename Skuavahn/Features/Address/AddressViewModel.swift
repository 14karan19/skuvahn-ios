//
//  AddressViewModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI
import Combine

@MainActor
final class AddressViewModel:
ObservableObject {

    @Published var state:
    AddressState = .idle

    @Published var addresses:
    [BookingAddresses] = []

    func getAddresses() {

        Task {

            do {

                state = .loading

                let response =
                try await AddressesAPI.shared
                    .getAddresses(
                        userId:
                        AppPref.shared.userId
                    )

                addresses =
                response.data ?? []

                state =
                .success(addresses)

            } catch {

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }

    func deleteAddress(
        addressId: String
    ) {

        Task {

            do {

                state = .loading

                let response =
                try await AddressesAPI.shared
                    .deleteAddress(
                        addressId:
                        addressId,

                        userId:
                        AppPref.shared.userId
                    )

                if response.success {

                    state =
                    .deleteSuccess(
                        response.message ??
                        "Deleted"
                    )

                    getAddresses()

                } else {

                    state =
                    .error(
                        response.message ??
                        "Delete failed"
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

    func addAddress(
        request: AddAddressRequest
    ) {

        Task {

            do {

                state = .loading

                let response =
                try await AddressesAPI.shared
                    .addAddress(
                        request:
                        request
                    )

                if response.success {

                    state =
                    .addSuccess(
                        response.message ??
                        "Address added"
                    )

                } else {

                    state =
                    .error(
                        response.message ??
                        "Failed"
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
