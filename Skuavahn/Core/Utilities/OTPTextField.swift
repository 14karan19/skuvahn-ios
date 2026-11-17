//
//  OTPTextField.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct OTPTextField: View {

    @Binding var otp: String

    @FocusState
    private var isFocused: Bool

    var body: some View {

        ZStack {

            TextField("", text: $otp)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($isFocused)
                .opacity(0.01)

            HStack(spacing: 8) {

                ForEach(0..<6, id: \.self) { index in

                    ZStack {

                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.otpFill)

                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                otp.count > index
                                ? Color.theme
                                : Color.otpStroke,
                                lineWidth: 1
                            )

                        Text(character(at: index))
                            .font(.plexSansSemiBold(18))
                            .foregroundColor(.black)
                    }
                    .frame(width: 42, height: 42)
                }
            }
        }
        .onTapGesture {
            isFocused = true
        }
        .onChange(of: otp) { _, value in

            otp = String(
                value.filter(\.isNumber)
                    .prefix(6)
            )
        }
    }

    private func character(
        at index: Int
    ) -> String {

        guard index < otp.count
        else {
            return ""
        }

        return String(
            Array(otp)[index]
        )
    }
}
