//
//  OTPView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct OTPView: View {

    let phone: String

    @StateObject
    private var viewModel = AuthViewModel()

    @Environment(\.dismiss)
    private var dismiss

    @State private var timer = 30
    @State private var canResend = false

    @State private var navigateHome = false
    @State private var navigateProfile = false

    var body: some View {

        VStack {

            Spacer()

            Image("ic_app_logo")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 180,
                    height: 160
                )

            Text(
                "Please enter the 6-digit code sent to your phone number"
            )
            .font(.plexSansRegular(14))
            .foregroundColor(.darkGrayCustom)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 18)
            .padding(.top, 18)

            OTPTextField(
                otp: $viewModel.otp
            )
            .padding(.top, 18)

            if case .error(let message) = viewModel.state {

                Text(message)
                    .font(.plexSansRegular(11))
                    .foregroundColor(.redError)
                    .padding(.top, 8)
            }

            Button {

                viewModel.resendOtp(
                    phone: phone
                )

                startTimer()

            } label: {

                Text("Resend OTP")
                    .font(.plexSansSemiBold(13))
                    .foregroundColor(
                        canResend
                        ? .theme
                        : .gray
                    )
                    .frame(
                        width: 150,
                        height: 36
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 8
                        )
                        .stroke(
                            canResend
                            ? Color.theme
                            : Color.gray,
                            lineWidth: 1
                        )
                    )
            }
            .disabled(!canResend)
            .padding(.top, 18)

            if !canResend {

                Text(
                    "Resend code in \(timer) second(s)"
                )
                .font(.plexSansSemiBold(11))
                .foregroundColor(.darkGrayCustom)
                .padding(.top, 4)
            }

            Button {

                viewModel.verifyOtp(
                    phone: phone
                )

            } label: {

                Text("Verify OTP")
                    .font(.plexSansSemiBold(15))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            }
            .background(
                viewModel.otp.count == 6
                ? Color.theme
                : Color.disableColor
            )
            .cornerRadius(8)
            .padding(.horizontal, 18)
            .padding(.top, 20)
            .disabled(
                viewModel.otp.count != 6
            )

            Button {

                dismiss()

            } label: {

                Text("Back")
                    .font(.plexSansSemiBold(13))
                    .foregroundColor(.darkestGray)
            }
            .padding(.top, 16)

            Spacer()

            FooterView()
                .padding(.bottom, 8)
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)

        .navigationDestination(
            isPresented: $navigateHome
        ) {
            HomeView()
        }

        .navigationDestination(
            isPresented: $navigateProfile
        ) {
            ProfileView()
        }

        .onAppear {

            startTimer()
        }

        .onReceive(
            viewModel.$state
        ) { state in

            switch state {

            case .verified(
                _,
                let profileComplete
            ):

                if profileComplete {
                    AppPref.shared.isLoggedIn = true
                    navigateHome = true
                } else {
                    navigateProfile = true
                }

            default:
                break
            }
        }

        .overlay {

            if viewModel.isLoading {

                ZStack {

                    Color.black.opacity(0.2)

                    ProgressView()
                        .scaleEffect(1.3)
                }
                .ignoresSafeArea()
            }
        }
    }

    private func startTimer() {

        timer = 30
        canResend = false

        Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { timerObj in

            if timer > 0 {

                timer -= 1

            } else {

                canResend = true

                timerObj.invalidate()
            }
        }
    }
}

#Preview {
    NavigationStack {
        OTPView(
            phone: "9876543210"
        )
    }
}
