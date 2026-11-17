//
//  ProfileState.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

enum ProfileState {

    case idle

    case loading

    case success

    case error(String)
    
    case deleteSuccess
}
