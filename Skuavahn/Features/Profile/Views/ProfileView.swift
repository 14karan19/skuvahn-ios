//
//  SwiftUIView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {

    let isMyProfile: Bool

    @StateObject
    private var viewModel = ProfileViewModel()

    @Environment(\.dismiss)
    private var dismiss

    @State private var fullName = ""
    @State private var email = ""

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?

    @State private var navigateHome = false
    
    @State private var navigateLogin = false
    @State private var showDeleteAlert = false
    
    init(
        isMyProfile: Bool = false
    ) {
        self.isMyProfile = isMyProfile
    }

    private var isValid: Bool {

        !fullName
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .isEmpty
        &&
        selectedImage != nil
    }

    var body: some View {

        VStack(spacing: 0) {

            headerView

            ScrollView {

                VStack(spacing: 0) {

                    profileImageSection

                    profileFields

                    if !isMyProfile {
                        saveButton
                    }
                }
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .task {

            guard isMyProfile else {
                return
            }

            fullName =
            AppPref.shared.name

            email =
            AppPref.shared.email

            if let url =
                URL(
                    string:
                    AppPref.shared.profilePic
                ) {

                Task {

                    do {

                        let (data, _) =
                        try await URLSession.shared
                            .data(from: url)

                        if let image =
                            UIImage(data: data) {

                            await MainActor.run {

                                selectedImage =
                                image
                            }
                        }

                    } catch {

                        print(error)
                    }
                }
            }
        }
        .navigationDestination(
            isPresented: $navigateHome
        ) {

            HomeView()
        }
        
        .navigationDestination(
            isPresented: $navigateLogin
        ) {
            LoginView()
        }

        .onReceive(viewModel.$state) { state in

            switch state {

            case .success:

                AppPref.shared.isLoggedIn = true
                navigateHome = true

            case .deleteSuccess:
                AppPref.shared.clearAll()
                navigateLogin = true

            default:
                break
            }
        }
        
        .confirmationDialog(
            "Delete Account",
            isPresented: $showDeleteAlert,
            titleVisibility: .visible
        ) {

            Button("Delete", role: .destructive) {
                Task {
                    viewModel.deleteUser()
                }
            }

            Button("Cancel", role: .cancel) { }

        } message: {

            Text("Are you sure you want to permanently delete your account?")
        }

        .overlay {

            if case .loading = viewModel.state {

                ZStack {

                    Color.black.opacity(0.2)

                    ProgressView()
                        .scaleEffect(1.3)
                }
                .ignoresSafeArea()
            }
        }
    }
}

// MARK: - Components

extension ProfileView {

    private var headerView: some View {

        HStack {

            Button {

                dismiss()

            } label: {

                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }

            Text(
                isMyProfile
                ? "My Profile"
                : "Profile"
            )
                .font(.plexSansMedium(18))

            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(Color.lightBlue)
    }

    private var profileImageSection: some View {

        ZStack(alignment: .bottomTrailing) {

            Group {

                if let image = selectedImage {

                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {

                    ProfilePlaceholderView()
                }
            }
            .scaledToFill()
            .frame(
                width: 100,
                height: 100
            )
            .clipShape(Circle())

            if !isMyProfile {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images
                ) {
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color.theme)
                            .frame(
                                width: 28,
                                height: 28
                            )
                        
                        Image(systemName: "camera.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    }
                }
            }
        }
        .padding(.top, 24)

        .onChange(
            of: selectedItem
        ) { _, item in

            Task {

                if let data =
                    try? await item?.loadTransferable(
                        type: Data.self
                    ),
                   let image =
                    UIImage(data: data) {

                    selectedImage = image
                }
            }
        }
    }

    private var profileFields: some View {

        VStack(spacing: 12) {

            TextField(
                "Full Name",
                text: $fullName
            )
            .disabled(isMyProfile)
            .padding(.horizontal, 12)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 8
                )
                .stroke(
                    Color.lightGrayStroke,
                    lineWidth: 1
                )
            )

            TextField(
                "Email (Optional)",
                text: $email
            )
            .disabled(isMyProfile)
            .keyboardType(.emailAddress)
            .padding(.horizontal, 12)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 8
                )
                .stroke(
                    Color.lightGrayStroke,
                    lineWidth: 1
                )
            )

            Text(AppPref.shared.phoneNumber)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.horizontal, 12)
                .frame(height: 50)
                .background(
                    Color.gray.opacity(0.1)
                )
                .cornerRadius(8)

            if isMyProfile {

                Button {

                    showDeleteAlert = true

                } label: {

                    Text("Delete Account")
                        .font(.plexSansSemiBold(15))
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                }
                .padding(.top, 12)
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 20)
    }

    private var saveButton: some View {

        Button {

            guard let image =
                selectedImage
            else {
                return
            }

            viewModel.fullName =
            fullName

            viewModel.email =
            email

            viewModel.selectedImage =
            image

            viewModel.saveProfile()

        } label: {

            Text("Save Profile")
                .font(
                    .plexSansSemiBold(15)
                )
                .foregroundColor(.white)
                .frame(
                    maxWidth: .infinity
                )
                .frame(height: 40)
        }
        .background(
            isValid
            ? Color.theme
            : Color.disableColor
        )
        .cornerRadius(8)
        .padding(.horizontal, 18)
        .padding(.top, 20)
        .disabled(!isValid)
    }
}

#Preview {

    NavigationStack {
        ProfileView(
            isMyProfile: true
        )
    }
}
