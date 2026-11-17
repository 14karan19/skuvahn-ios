//
//  ChildAPI.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//


import Foundation

final class ChildAPI {

    static let shared = ChildAPI()

    private init() {}

    // MARK: Get Children

    func getChildren(
        userId: String
    ) async throws
    -> BaseResponse<[Children]> {

        try await NetworkManager.shared.get(
            endpoint:
                EndPoints.baseURL +
                "\(EndPoints.children)?userId=\(userId)",

            token:
                AppPref.shared.token,

            responseType:
                BaseResponse<[Children]>.self
        )
    }

    // MARK: Get Schools

    func getSchools()
    async throws
    -> BaseResponse<[Schoool]> {

        try await NetworkManager.shared.get(
            endpoint:
                EndPoints.baseURL +
                EndPoints.schools,

            token:
                AppPref.shared.token,

            responseType:
                BaseResponse<[Schoool]>.self
        )
    }

    // MARK: Add Child

    func addChild(
        request: ChildAddRequest
    ) async throws
    -> BaseResponse<String> {

        try await NetworkManager.shared.post(
            endpoint:
                EndPoints.baseURL +
                EndPoints.children,

            token:
                AppPref.shared.token,

            body:
                request,

            responseType:
                BaseResponse<String>.self
        )
    }

    // MARK: Update Child

    func updateChild(
        childId: String,
        request: ChildUpdateRequest
    ) async throws
    -> BaseResponse<Bool> {

        try await NetworkManager.shared.put(
            endpoint:
                EndPoints.baseURL +
                "\(EndPoints.children)/\(childId)",

            token:
                AppPref.shared.token,

            body:
                request,

            responseType:
                BaseResponse<Bool>.self
        )
    }

    // MARK: Delete Child

    func deleteChild(
        childId: String,
        userId: String
    ) async throws
    -> BaseResponse<Bool> {

        try await NetworkManager.shared.delete(
            endpoint:
                EndPoints.baseURL +
                "\(EndPoints.deleteChildren)/\(childId)?userId=\(userId)",

            token:
                AppPref.shared.token,

            responseType:
                BaseResponse<Bool>.self
        )
    }
}
