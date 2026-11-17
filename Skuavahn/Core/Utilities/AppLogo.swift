//
//  AppLogo.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct AppLogo: View {

    var body: some View {

        Image("app_logo")
            .resizable()
            .scaledToFit()
            .frame(
                width: 150,
                height: 160
            )
    }
}
