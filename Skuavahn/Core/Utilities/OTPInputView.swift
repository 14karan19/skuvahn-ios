//
//  OTPInputView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct OTPInputView: View {

    @Binding var otp: String

    @FocusState private var isFocused: Bool

    var body: some View {

        ZStack {

            TextField("", text: $otp)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($isFocused)
                .opacity(0.01)
                .frame(width: 1, height: 1)
                .onChange(of: otp) { _, value in

                    let filtered =
                    value.filter(\.isNumber)

                    otp =
                    String(filtered.prefix(6))
                }

            HStack(spacing: 12) {

                ForEach(0..<6, id: \.self) { index in

                    OTPBoxView(
                        value: character(at: index),
                        isFocused: index == otp.count
                    )
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {

            isFocused = true
        }
        .onAppear {

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 0.3
            ) {

                isFocused = true
            }
        }
    }

    private func character(
        at index: Int
    ) -> String {

        guard index < otp.count else {
            return ""
        }

        return String(Array(otp)[index])
    }
}
