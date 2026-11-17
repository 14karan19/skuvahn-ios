//
//  AppPref.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

final class AppPref {

    static let shared = AppPref()

    private init() {}

    private let defaults =
    UserDefaults.standard

    var phoneNumber: String {

        get {
            defaults.string(
                forKey: "phone"
            ) ?? ""
        }

        set {
            defaults.set(
                newValue,
                forKey: "phone"
            )
        }
    }
    
    var name: String {

        get {
            defaults.string(
                forKey: "name"
            ) ?? ""
        }

        set {
            defaults.set(
                newValue,
                forKey: "name"
            )
        }
    }
    
    var email: String {

        get {
            defaults.string(
                forKey: "email"
            ) ?? ""
        }

        set {
            defaults.set(
                newValue,
                forKey: "email"
            )
        }
    }
    
    var profilePic: String {

        get {
            defaults.string(
                forKey: "profilePic"
            ) ?? ""
        }

        set {
            defaults.set(
                newValue,
                forKey: "profilePic"
            )
        }
    }
    

    var token: String {

        get {
            defaults.string(
                forKey: "token"
            ) ?? ""
        }

        set {
            defaults.set(
                newValue,
                forKey: "token"
            )
        }
    }

    var userId: String {

        get {
            defaults.string(
                forKey: "userId"
            ) ?? ""
        }

        set {
            defaults.set(
                newValue,
                forKey: "userId"
            )
        }
    }

    var isLoggedIn: Bool {

        get {
            defaults.bool(
                forKey: "isLoggedIn"
            )
        }

        set {
            defaults.set(
                newValue,
                forKey: "isLoggedIn"
            )
        }
    }

    func clearAll() {

        defaults.removePersistentDomain(
            forName:
                Bundle.main.bundleIdentifier!
        )
    }
}
