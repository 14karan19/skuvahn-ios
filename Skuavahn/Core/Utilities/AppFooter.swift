//
//  AppFooter.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct AppFooter: View {

    let version: String

    var body: some View {

        VStack(spacing: 2) {

            Text("Version \(version)")
                .font(.notoSansRegular(11))
                .foregroundColor(.blackCustom)

            Text("Powered By:")
                .font(.notoSansBold(9))
                .foregroundColor(.blackCustom)

            Text("SkuVahn Pvt. Ltd.")
                .font(.notoSansRegular(9))
                .foregroundColor(.blackCustom)
        }
    }
}
