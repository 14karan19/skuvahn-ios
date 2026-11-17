//
//  ProfileViewModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI
import Combine

@MainActor
final class ProfileViewModel:
ObservableObject {

    @Published var state:
    ProfileState = .idle

    @Published var fullName = ""

    @Published var email = ""

    @Published var selectedImage:
    UIImage?

    func validate() -> Bool {

        guard !fullName
            .trimmingCharacters(
                in: .whitespaces
            )
            .isEmpty
        else {
            return false
        }

        if !email.isEmpty {

            let regex =
            "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

            let predicate =
            NSPredicate(
                format: "SELF MATCHES %@",
                regex
            )

            if !predicate.evaluate(
                with: email
            ) {
                return false
            }
        }

        return selectedImage != nil
    }

    func deleteUser() {
        Task {

            do {

                state = .loading

                let request = DeleteUserRequest(
                    userId: AppPref.shared.userId
                )

                let response = try await AuthAPI.shared.deleteUser(
                    request: request,
                    token: AppPref.shared.token
                )

                if response.success {

                    state = .deleteSuccess

                } else {

                    state = .error(
                        response.message ?? "Something went wrong"
                    )
                }

            } catch {

                state = .error(
                    error.localizedDescription
                )
            }
        }
    }
    
    func saveProfile() {

        guard let image =
                selectedImage,
              let imageData =
                ImageCompressor.compress(
                    image: image
                )
        else {
            return
        }

        Task {

            do {

                state = .loading

                let imageUrl =
                try await
                S3Uploader.uploadImage(
                    data: imageData
                )

                let request =
                SaveGuardianRequest(
                    userId:
                    AppPref.shared.userId,

                    fullName:
                    fullName,

                    phone:
                    AppPref.shared.phoneNumber,

                    email:
                    email.isEmpty
                    ? nil
                    : email,

                    imageUrl:
                    imageUrl
                )

                let response =
                try await
                AuthAPI.shared
                    .saveGuardian(
                        request: request,
                        token:
                        AppPref.shared.token
                    )

                if response.success {

                    AppPref.shared.name =
                    fullName

                    AppPref.shared.email =
                    email

                    AppPref.shared.profilePic =
                    imageUrl

                    AppPref.shared.isLoggedIn =
                    true

                    state = .success

                } else {

                    state = .error(
                        response.message ??
                        "Something went wrong"
                    )
                }

            } catch {

                state = .error(
                    error.localizedDescription
                )
            }
        }
    }
}
