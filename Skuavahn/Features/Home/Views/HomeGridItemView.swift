//
//  HomeGridItemView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct HomeGridItemView: View {

    let image: String
    let title: String
    let action: () -> Void

    var body: some View {

        Button(
            action: action
        ) {

            VStack(spacing: 8) {

                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 48,
                        height: 48
                    )

                Text(title)
                    .font(
                        .notoSansMedium(12)
                    )
                    .foregroundColor(
                        .textPrimary
                    )
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(.white)
            .cornerRadius(12)
            .shadow(
                color:
                    .black.opacity(0.05),
                radius: 4
            )
        }
    }
}
