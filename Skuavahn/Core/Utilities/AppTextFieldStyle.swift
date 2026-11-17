//
//  AppTextFieldStyle.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct AppTextFieldStyle: ViewModifier {

    func body(content: Content) -> some View {

        content
            .font(.plexSansRegular(13))
            .foregroundColor(.blackCustom)
            .padding(.horizontal, 12)
            .frame(height: Dimens.textFieldHeight)
            .background(Color.lightGrayCustom)
            .overlay(
                RoundedRectangle(cornerRadius: Dimens.radius8)
                    .stroke(
                        Color.lightGrayStroke,
                        lineWidth: 1
                    )
            )
    }
}

extension View {

    func appTextFieldStyle() -> some View {
        modifier(AppTextFieldStyle())
    }
}
