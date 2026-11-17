//
//  AuthViewModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 02/06/26.
//

import Foundation
import Combine

@MainActor
final class AuthViewModel:
ObservableObject {

    @Published var state:
    AuthState = .idle

    @Published var mobileNumber = ""

    @Published var otp = ""

    @Published var errorMessage = ""

    @Published var isLoading = false

    // MARK: Validation

    func validateMobile() -> Bool {

        let regex =
        "^[6-9][0-9]{9}$"

        return NSPredicate(
            format:
                "SELF MATCHES %@",
            regex
        )
        .evaluate(
            with:
                mobileNumber
        )
    }

    // MARK: Send OTP

    func sendOtp() {

        guard validateMobile()
        else {

            errorMessage =
            "Please enter valid mobile number"

            return
        }

        errorMessage = ""

        isLoading = true

        state = .loading

        Task {

            do {

                let response =
                try await AuthAPI.shared
                    .sendOtp(
                        phone:
                            mobileNumber
                    )

                isLoading = false

                if response.success,
                   let data =
                    response.data {

                    AppPref.shared.userId =
                    data.userId

                    state =
                    .otpSent(
                        userId:
                            data.userId,

                        phone:
                            data.phone,

                        isNewUser:
                            data.isNewUser
                    )

                } else {

                    state =
                    .error(
                        response.message ??
                        "Failed to send OTP"
                    )
                }

            } catch {

                isLoading = false

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }

    // MARK: Resend OTP

    func resendOtp(
        phone: String
    ) {

        isLoading = true

        state = .loading

        Task {

            do {

                let response =
                try await AuthAPI.shared
                    .resendOtp(
                        phone:
                            phone
                    )

                isLoading = false

                if response.success {

                    state =
                    .codeSent

                } else {

                    state =
                    .error(
                        response.message ??
                        "Failed to resend OTP"
                    )
                }

            } catch {

                isLoading = false

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }

    // MARK: Verify OTP

    func verifyOtp(
        phone: String
    ) {

        guard otp.count == 6
        else {
            return
        }

        isLoading = true

        state = .loading

        Task {

            do {

                let response =
                try await AuthAPI.shared
                    .verifyOtp(
                        phone:
                            phone,

                        otp:
                            otp
                    )

                isLoading = false

                if response.success,
                   let data =
                    response.data {

                    AppPref.shared.token =
                    "Bearer \(data.accessToken)"

                    AppPref.shared.phoneNumber =
                    phone

                    AppPref.shared.isLoggedIn =
                    data.isProfileComplete

                    state =
                    .verified(
                        accessToken:
                            data.accessToken,

                        isProfileComplete:
                            data.isProfileComplete
                    )

                } else {

                    state =
                    .error(
                        response.message ??
                        "Invalid OTP"
                    )
                }

            } catch {

                isLoading = false

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }
}
