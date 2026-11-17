//
//  HomeState.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

enum HomeState {

    case idle

    case loading

    case success(HomeData)

    case error(String)
}
