//
//  BookingsResponseModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

struct Booking: Codable, Identifiable {

    let id: String
    let status: Int

    let createdAt: String?
    let tenure: String?
    let startDate: String?

    let child: Child
    let school: School
    let address: Address

    let route: Route?

    let captain: Captain?
    let vehicle: Vehicle?
    let camera: Camera?
}

struct Child: Codable {

    let id: String
    let fullName: String
    let dob: String

    let grade: String?

    let imageUrl: String?

    let emergencyContactName: String?
    let emergencyContactPhone: String?
}

struct School: Codable {

    let id: String
    let name: String

    let address: String?
    let pincode: String?
    let landmark: String?

    let latitude: String?
    let longitude: String?

    let contactPhone: String?
    let contactEmail: String?
}

struct Address: Codable {

    let id: String

    let latitude: String
    let longitude: String

    let locality: String
    let fullAddress: String

    let landmark: String?
    let pincode: String?

    let addressType: String
}

struct Route: Codable {

    let id: String

    let routeStop: String

    let landmark: String?
    let latitude: String?
    let longitude: String?

    let isActive: Bool
}

struct Captain: Codable {

    let id: String

    let fullName: String
    let phone: String

    let email: String?
    let imageUrl: String?
}

struct Vehicle: Codable {

    let id: String

    let registrationNumber: String
    let model: String
    let color: String

    let seatCapacity: Int

    let rcNumber: String

    let insuranceExpiry: String

    let fitnessExpiry: String?
    let pollutionExpiry: String?

    let isActive: Bool
}

struct Camera: Codable {

    let id: String

    let cameraNumber: String
    let cameraKey: String

    let simNumber: String?
    let streamingUrl: String?
    let status: String?

    let validity: String
}
