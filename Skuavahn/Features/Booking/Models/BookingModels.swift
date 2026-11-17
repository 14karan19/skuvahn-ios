//
//  BookingModels.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

// MARK: - Get Bookings Response

struct BookingResponse: Codable {

    let success: Bool
    let statusCode: Int
    let message: String?
    let messages: [String]?
    let errors: [String: [String]]?
    let data: [Boooking]?
}

// MARK: - Booking

struct Boooking: Codable, Identifiable, Hashable {

    let id: String?

    let status: Int?

    let createdAt: String?

    let tenure: String?

    let startDate: String?

    let child: BookingChild?

    let school: BookingSchool?

    let address: BookingAddress?

    let route: BookingRoute?

    let captain: BookingCaptain?

    let vehicle: BookingVehicle?

    let camera: BookingCamera?
}

// MARK: - Child

struct BookingChild: Codable, Hashable {

    let id: String?

    let fullName: String?

    let dob: String?

    let studentClass: String?

    let section: String?

    let imageUrl: String?

    let emergencyContactName: String?

    let emergencyContactPhone: String?

    enum CodingKeys: String, CodingKey {

        case id
        case fullName
        case dob
        case studentClass = "class"
        case section
        case imageUrl
        case emergencyContactName
        case emergencyContactPhone
    }
}

// MARK: - School

struct BookingSchool: Codable, Hashable {

    let id: String?

    let name: String?

    let address: String?

    let pincode: String?

    let landmark: String?

    let latitude: String?

    let longitude: String?

    let contactPhone: String?

    let contactEmail: String?
}

// MARK: - Address

struct BookingAddress: Codable, Hashable {

    let id: String?

    let latitude: String?

    let longitude: String?

    let locality: String?

    let fullAddress: String?

    let landmark: String?

    let pincode: String?

    let addressType: String?
}

// MARK: - Route

struct BookingRoute: Codable, Hashable {

    let id: String?

    let routeStop: String?

    let landmark: String?

    let latitude: String?

    let longitude: String?

    let isActive: Bool?
}

// MARK: - Captain

struct BookingCaptain: Codable, Hashable {

    let id: String?

    let fullName: String?

    let phone: String?

    let email: String?

    let imageUrl: String?
}

// MARK: - Vehicle

struct BookingVehicle: Codable, Hashable {

    let id: String?

    let registrationNumber: String?

    let model: String?

    let color: String?

    let seatCapacity: Int?

    let rcNumber: String?

    let insuranceExpiry: String?

    let fitnessExpiry: String?

    let pollutionExpiry: String?

    let isActive: Bool?
}

// MARK: - Camera

struct BookingCamera: Codable, Hashable {

    let id: String?

    let cameraNumber: String?

    let cameraKey: String?

    let simNumber: String?

    let streamingUrl: String?

    let status: String?

    let validity: String?
}

// MARK: - Create Booking Request

struct BookingCreateRequest: Codable {

    let childId: String

    let addressId: String

    let schoolId: String

    let tenure: String

    let startDate: String

    let userId: String
}
