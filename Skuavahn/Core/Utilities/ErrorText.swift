//
//  ErrorText.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct ErrorText: View {

    let message: String

    var body: some View {

        Text(message)
            .font(.notoSansRegular(10))
            .foregroundColor(.redError)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
    }
}
