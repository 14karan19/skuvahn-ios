//
//  AppPrimaryButtonStyle.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct AppPrimaryButtonStyle: ButtonStyle {

    var enabled: Bool

    func makeBody(configuration: Configuration) -> some View {

        configuration.label
            .font(.plexSansSemiBold(14))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: Dimens.buttonHeight)
            .background(
                enabled
                ? Color.theme
                : Color.disableColor
            )
            .cornerRadius(Dimens.radius8)
            .shadow(
                color: .black.opacity(0.15),
                radius: 3,
                x: 0,
                y: 2
            )
            .scaleEffect(
                configuration.isPressed ? 0.98 : 1.0
            )
    }
}
