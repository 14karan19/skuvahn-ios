//
//  HomeViewModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel:
ObservableObject {

    @Published var state:
    HomeState = .idle

    func getHome() {

        Task {

            do {

                state = .loading

                let response =
                try await AuthAPI.shared
                    .getHome()

                if response.success,
                   let data =
                    response.data {

                    AppPref.shared.phoneNumber =
                    data.user?.phone ?? ""

                    AppPref.shared.email =
                    data.user?.email ?? ""

                    AppPref.shared.profilePic =
                    data.user?.imageUrl ?? ""

                    AppPref.shared.name =
                    data.user?.fullName ?? ""

                    state = .success(data)

                } else {

                    state = .error(
                        response.message ??
                        "Something went wrong"
                    )
                }

            } catch {

                state = .error(
                    error.localizedDescription
                )
            }
        }
    }
}
