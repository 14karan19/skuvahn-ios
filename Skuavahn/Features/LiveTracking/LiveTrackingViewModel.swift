//
//  LiveTrackingViewModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI
import Combine

@MainActor
final class LiveTrackingViewModel:
ObservableObject {

    @Published var vehicle: LiveTrackingVehicle?
    
    @Published var state:
    LiveTrackingState = .idle

    func getLiveLocation(
        terminalNo: String,
        key: String
    ) {

        Task {

            do {

                state = .loading

                let response =
                try await
                LiveTrackingAPI.shared
                    .getLiveLocation(
                        terminalNo:
                        terminalNo,

                        key:
                        key
                    )

                if response.code == 200,
                   
                    let vehicle = response.data?.list.first {

                        self.vehicle = vehicle

                        state = .success(vehicle)
                    
                } else {

                    state =
                    .error(
                        "No data found"
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
