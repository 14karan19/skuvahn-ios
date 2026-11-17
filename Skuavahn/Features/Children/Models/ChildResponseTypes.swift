//
//  ChildResponseTypes.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//


import Foundation

struct ChildAddResponse: Codable {

    let success: Bool
    let statusCode: Int
    let message: String?
    let messages: [String]?
    let errors: [String: [String]]?
    let data: String?
}

struct ChildDeleteResponse: Codable {

    let success: Bool
    let statusCode: Int
    let message: String?
    let messages: [String]?
    let errors: [String: [String]]?
    let data: Bool
}
