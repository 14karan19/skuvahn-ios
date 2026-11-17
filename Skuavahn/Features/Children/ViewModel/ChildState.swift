//
//  ChildState.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

enum ChildState {

    case idle

    case loading

    case success([Children])

    case schoolListSuccess([Schoool])

    case addSuccess(String)

    case updateSuccess(String)

    case deleteSuccess(String)

    case error(String)
}
