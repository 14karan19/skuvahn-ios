//
//  UserProfileView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import SwiftUI
import UIKit

struct UserProfileView: View {
    
    @State private var navigateToLogin = false
    
    @Environment(\.dismiss)
    private var dismiss
    
    @State private var showLogoutAlert = false
    @State private var showMyProfile = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            headerView
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
                    profileSection
                    
                    Divider()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                    
                    accountSection
                    
                    Divider()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                    
                    otherSection
                    
                    Divider()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                    
                    logoutSection
                }
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        
        .navigationDestination(
            isPresented: $showMyProfile
        ) {
            
            ProfileView(
                isMyProfile: true
            )
        }
        .navigationDestination(
            isPresented: $navigateToLogin
        ) {
            LoginView()
        }
        
        .alert(
            "Logout",
            isPresented: $showLogoutAlert
        ) {
            
            Button(
                "Cancel",
                role: .cancel
            ) {}
            
            Button(
                "Logout",
                role: .destructive
            ) {
                
                AppPref.shared.clearAll()
                
                navigateToLogin = true
            }
            
        } message: {
            
            Text(
                "Are you sure you want to logout?"
            )
        }
    }
}

// MARK: Header

extension UserProfileView {
    
    private var headerView: some View {
        
        HStack {
            
            Button {
                
                dismiss()
                
            } label: {
                
                Image(
                    systemName:
                        "chevron.left"
                )
                .foregroundColor(.black)
            }
            
            Text("Profile")
                .font(
                    .plexSansMedium(18)
                )
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(Color.lightBlue)
    }
    
}

// MARK: Profile Section

extension UserProfileView {
    
    private var profileSection: some View {
        
        HStack(
            alignment: .center,
            spacing: 12
        ) {
            
            Group {
                
                if let url =
                    URL(
                        string:
                            AppPref.shared.profilePic
                    ),
                   !AppPref.shared.profilePic.isEmpty {
                    
                    AsyncImage(
                        url: url
                    ) { image in
                        
                        image
                            .resizable()
                            .scaledToFill()
                        
                    } placeholder: {
                        
                        ProfilePlaceholderView()
                    }
                    
                } else {
                    
                    ProfilePlaceholderView()
                }
            }
            .frame(
                width: 60,
                height: 60
            )
            .clipShape(Circle())
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text(
                    AppPref.shared.name
                )
                .font(
                    .notoSansBold(16)
                )
                .foregroundColor(
                    .theme
                )
                
                Text(
                    AppPref.shared.email
                )
                .font(
                    .notoSansMedium(12)
                )
                .foregroundColor(
                    .gray
                )
                
                Text(
                    "+91 \(AppPref.shared.phoneNumber)"
                )
                .font(
                    .notoSansMedium(12)
                )
                .foregroundColor(
                    .gray
                )
            }
            
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
    }
    
}

// MARK: Account Section

extension UserProfileView {
    
    private var accountSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            Text("ACCOUNT")
                .font(
                    .plexSansRegular(13)
                )
                .foregroundColor(
                    .darkGrayCustom
                )
                .padding(.horizontal, 24)
            
            Button {
                showMyProfile = true
            } label: {
                
                HStack {
                    
                    Text("My Profile")
                        .font(
                            .plexSansRegular(12)
                        )
                        .foregroundColor(
                            .darkestGray
                        )
                    
                    Spacer()
                    
                    Image(
                        systemName:
                            "person.fill"
                    )
                    .foregroundColor(
                        .black
                    )
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
}

// MARK: Other Section

extension UserProfileView {
    
    private var otherSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            Text("OTHER")
                .font(
                    .plexSansRegular(13)
                )
                .foregroundColor(
                    .darkGrayCustom
                )
                .padding(.horizontal, 24)
            
            Button {
                
                contactSupport()
                
            } label: {
                
                HStack {
                    
                    Text("Contact Support")
                        .font(
                            .plexSansRegular(12)
                        )
                        .foregroundColor(
                            .darkestGray
                        )
                    
                    Spacer()
                    
                    Image(
                        systemName:
                            "questionmark.circle"
                    )
                    .foregroundColor(
                        .black
                    )
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
}

// MARK: Logout

extension UserProfileView {
    
    private var logoutSection: some View {
        
        Button {
            
            showLogoutAlert = true
            
        } label: {
            
            HStack {
                
                Text("Logout")
                    .font(
                        .plexSansRegular(12)
                    )
                    .foregroundColor(
                        .red
                    )
                
                Spacer()
                
                Image(
                    systemName:
                        "rectangle.portrait.and.arrow.right"
                )
                .foregroundColor(
                    .red
                )
            }
            .padding(.horizontal, 24)
        }
    }
    
}

// MARK: Contact Support

extension UserProfileView {
    
    private func contactSupport() {
        
        let email =
        "karan.lamba.1419@gmail.com"
        
        let subject =
        "Skuavahn App Support"
        
        let body =
    """
    
    
    
    
    Device: \(UIDevice.current.model)
    System: \(UIDevice.current.systemName)
    Version: \(UIDevice.current.systemVersion)
    
    """
        
        let urlString =
        "mailto:\(email)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        if let url =
            URL(string: urlString) {
            
            UIApplication.shared.open(
                url
            )
        }
    }
    
}

#Preview {
    
    NavigationStack {
        
        UserProfileView()
    }
    
}
