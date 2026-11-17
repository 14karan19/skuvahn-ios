//
//  SplashView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct SplashView: View {

    @State private var navigateLogin = false
    @State private var navigateHome = false

    var body: some View {

        NavigationStack {

            ZStack {

                Color.white
                    .ignoresSafeArea()

                Image("ic_app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 180,
                        height: 180
                    )
            }
            .navigationDestination(
                isPresented: $navigateLogin
            ) {
                LoginView()
            }
            .navigationDestination(
                isPresented: $navigateHome
            ) {
                HomeView()
            }
            .onAppear {

                DispatchQueue.main.asyncAfter(
                    deadline: .now() + 2
                ) {

                    if AppPref.shared.isLoggedIn {

                        navigateHome = true

                    } else {

                        navigateLogin = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
