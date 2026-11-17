//
//  ProfilePlaceholderView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 19/06/26.
//

import SwiftUI

struct ProfilePlaceholderView: View {

    var body: some View {

        ZStack {

            Circle()
                .fill(Color.gray.opacity(0.15))

            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 45,
                    height: 45
                )
                .foregroundColor(
                    .gray.opacity(0.7)
                )
        }
        .frame(
            width: 100,
            height: 100
        )
    }
}
