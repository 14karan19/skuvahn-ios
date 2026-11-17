//
//  ChildViewModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//


import SwiftUI
import Combine

@MainActor
final class ChildViewModel: ObservableObject {

    @Published var state: ChildState = .idle

    @Published var children: [Children] = []

    @Published var schools: [Schoool] = []

    // MARK: Get Children

    func getChildren() {

        Task {

            do {

                state = .loading

                let response =
                try await ChildAPI.shared
                    .getChildren(
                        userId:
                        AppPref.shared.userId
                    )

                let list =
                response.data ?? []

                children = list

                state = .success(list)

            } catch {

                state = .error(
                    error.localizedDescription
                )
            }
        }
    }

    // MARK: Get Schools

    func getSchools() {

        Task {

            do {

                let response =
                try await ChildAPI.shared
                    .getSchools()

                let list =
                response.data ?? []

                schools = list

                state =
                .schoolListSuccess(
                    list
                )

            } catch {

                state = .error(
                    error.localizedDescription
                )
            }
        }
    }

    // MARK: Delete Child

    func deleteChild(
        childId: String
    ) {

        Task {

            do {

                state = .loading

                let response =
                try await ChildAPI.shared
                    .deleteChild(
                        childId: childId,
                        userId:
                        AppPref.shared.userId
                    )

                if response.success {

                    state =
                    .deleteSuccess(
                        response.message ??
                        "Deleted successfully"
                    )

                    getChildren()

                } else {

                    state =
                    .error(
                        response.message ??
                        "Delete failed"
                    )
                }

            } catch {

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }

    // MARK: Add Child

    func addChild(
        fullName: String,
        dob: String,
        studentClass: String,
        section: String,
        schoolId: String,
        emergencyName: String,
        emergencyPhone: String,
        image: UIImage
    ) {

        Task {

            do {

                state = .loading

                guard let imageData =
                        ImageCompressor.compress(
                            image: image
                        )
                else {

                    state =
                    .error(
                        "Unable to process image"
                    )

                    return
                }

                let imageUrl =
                try await
                S3Uploader.uploadImage(
                    data: imageData
                )

                let request =
                ChildAddRequest(
                    fullName:
                    fullName,

                    dob:
                    dob,

                    grade:
                    "",

                    studentClass:
                    studentClass,

                    section:
                    section,

                    schoolId:
                    schoolId,

                    imageUrl:
                    imageUrl,

                    emergencyContactName:
                    emergencyName,

                    emergencyContactPhone:
                    emergencyPhone,

                    userId:
                    AppPref.shared.userId
                )

                let response =
                try await ChildAPI.shared
                    .addChild(
                        request:
                        request
                    )

                if response.success {

                    state =
                    .addSuccess(
                        response.message ??
                        "Child added successfully"
                    )

                    getChildren()
                } else {

                    state =
                    .error(
                        response.message ??
                        "Add child failed"
                    )
                }

            } catch {

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }

    // MARK: Update Child

    func updateChild(
        child: Children,
        fullName: String,
        dob: String,
        studentClass: String,
        section: String,
        schoolId: String,
        emergencyName: String,
        emergencyPhone: String,
        image: UIImage?
    ) {

        Task {

            do {

                state = .loading

                var imageUrl =
                child.imageUrl ?? ""

                if let image {

                    guard let imageData =
                            ImageCompressor.compress(
                                image: image
                            )
                    else {

                        state =
                        .error(
                            "Unable to process image"
                        )

                        return
                    }

                    imageUrl =
                    try await
                    S3Uploader.uploadImage(
                        data: imageData
                    )
                }

                let request =
                ChildUpdateRequest(

                    id:
                    child.id ?? "",

                    fullName:
                    fullName,

                    dob:
                    dob,

                    grade:
                    "",

                    studentClass:
                    studentClass,

                    section:
                    section,

                    schoolId:
                    schoolId,

                    imageUrl:
                    imageUrl,

                    emergencyContactName:
                    emergencyName,

                    emergencyContactPhone:
                    emergencyPhone,

                    userId:
                    AppPref.shared.userId
                )

                let response =
                try await ChildAPI.shared
                    .updateChild(
                        childId:
                        child.id ?? "",

                        request:
                        request
                    )

                if response.success {

                    state =
                    .updateSuccess(
                        response.message ??
                        "Child updated successfully"
                    )
                    
                    getChildren()

                } else {

                    state =
                    .error(
                        response.message ??
                        "Update failed"
                    )
                }

            } catch {

                state =
                .error(
                    error.localizedDescription
                )
            }
        }
    }
}
