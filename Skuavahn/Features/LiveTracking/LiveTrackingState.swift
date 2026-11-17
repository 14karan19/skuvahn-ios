//
//  LiveTrackingState.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import Foundation

enum LiveTrackingState {

    case idle

    case loading

    case success(LiveTrackingVehicle?)

    case error(String)
}
