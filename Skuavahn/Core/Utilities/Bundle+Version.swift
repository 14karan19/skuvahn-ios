//
//  Bundle+Version.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import Foundation

extension Bundle {

    var appVersion: String {
        infoDictionary?["CFBundleShortVersionString"]
        as? String ?? "1.0.0"
    }
}
