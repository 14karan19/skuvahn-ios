//
//  LoginView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 02/06/26.
//


import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = AuthViewModel()

    @State private var navigateOTP = false
    @State private var phone = ""

    var body: some View {

        NavigationStack {

            VStack(spacing: 0) {

                Spacer()
                    .frame(height: 180)

                // MARK: LOGO

                Image("ic_app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 150,
                        height: 160
                    )

                // MARK: TITLE

                Text("Login with your\nphone number.")
                    .font(.plexSansBold(22))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 12)

                // MARK: MOBILE FIELD

                VStack(alignment: .leading, spacing: 4) {

                    TextField(
                        "",
                        text: $viewModel.mobileNumber
                    )
                    .placeholder(
                        when: viewModel.mobileNumber.isEmpty
                    ) {

                        Text("Enter your phone number")
                            .font(.plexSansRegular(14))
                            .foregroundColor(.darkGrayCustom)
                    }
                    .keyboardType(.numberPad)
                    .font(.plexSansRegular(14))
                    .padding(.horizontal, 16)
                    .frame(height: 42)
                    .background(
                        Color.lightGrayCustom
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 8
                        )
                        .stroke(
                            Color.lightGrayStroke,
                            lineWidth: 1
                        )
                    )
                    .cornerRadius(8)
                    .onChange(
                        of: viewModel.mobileNumber
                    ) { _, value in

                        let filtered =
                        value.filter {
                            $0.isNumber
                        }

                        viewModel.mobileNumber =
                        String(filtered.prefix(10))
                    }

                    if !viewModel.errorMessage.isEmpty {

                        Text(viewModel.errorMessage)
                            .font(.plexSansRegular(11))
                            .foregroundColor(.redError)
                            .padding(.leading, 4)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 24)

                // MARK: LOGIN BUTTON

                Button {
                    viewModel.sendOtp()
                } label: {

                    Text("Login")
                        .font(.plexSansSemiBold(14))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                }
                .background(
                    viewModel.validateMobile()
                    ? Color.theme
                    : Color.disableColor
                )
                .cornerRadius(8)
                .shadow(
                    color: .black.opacity(0.15),
                    radius: 6,
                    x: 0,
                    y: 4
                )
                .padding(.horizontal, 18)
                .padding(.top, 24)
                .disabled(
                    !viewModel.validateMobile()
                )

                Spacer()

                FooterView()
                    .padding(.bottom, 6)
            }
            .background(Color.white)
            .navigationBarBackButtonHidden()

            .navigationDestination(
                isPresented: $navigateOTP
            ) {

                OTPView(
                    phone: phone
                )
            }

            .onChange(
                of: viewModel.state
            ) { _, state in

                switch state {

                case .otpSent(
                    _,
                    let phoneNumber,
                    _
                ):

                    phone = phoneNumber
                    navigateOTP = true

                case .error(
                    let message
                ):

                    viewModel.errorMessage = message

                default:
                    break
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
