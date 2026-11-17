//
//  FooterView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct FooterView: View {

    var body: some View {

        VStack(spacing: 1) {

            Text("Version 1.0.0")
                .font(.notoSansRegular(7))

            Text("Powered By:")
                .font(.notoSansBold(5))

            Text("SkuVahn Pvt. Ltd.")
                .font(.notoSansRegular(5))
        }
        .foregroundColor(.black)
    }
}
