//
//  OTPBoxView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct OTPBoxView: View {

    let value: String
    let isFocused: Bool

    var body: some View {

        ZStack {

            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(Color.otpFill)

            RoundedRectangle(
                cornerRadius: 10
            )
            .stroke(
                isFocused
                ? Color.theme
                : Color.otpStroke,
                lineWidth: 1
            )

            Text(value)
                .font(.plexSansSemiBold(20))
                .foregroundColor(.black)
        }
        .frame(
            width: 46,
            height: 46
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 3,
            x: 0,
            y: 2
        )
    }
}
