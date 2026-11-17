//
//  MapVehicle.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import Foundation
import MapKit

struct MapVehicle: Identifiable {

    let id = UUID()

    let location: CLLocationCoordinate2D
}
