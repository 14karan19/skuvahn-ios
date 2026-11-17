//
//  HomeView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct HomeView: View {

    @State private var navigateToChildren = false
    @State private var navigateToProfile = false
    @State private var navigateToBookings = false
    @State private var navigateToAddress = false
    @State private var navigateToAddBookings = false
    
    @StateObject
    private var viewModel =
    HomeViewModel()

    var body: some View {

        ZStack {

            Color.lightBlue
                .ignoresSafeArea()

            content
        }
        .navigationDestination(
            isPresented:
                $navigateToChildren
        ) {
            ChildrenView()
        }
        .navigationDestination(
            isPresented: $navigateToProfile
        ) {
            UserProfileView()
        }
        .navigationDestination(
            isPresented: $navigateToBookings
        ) {
            BookingsView()
        }
        .navigationDestination(
            isPresented: $navigateToAddress
        ) {
            AddressView()
        }
        .navigationDestination(
            isPresented: $navigateToAddBookings
        ) {
            BookingAddView()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {

            viewModel.getHome()
        }
    }

    @ViewBuilder
    private var content: some View {

        switch viewModel.state {

        case .loading:

            ProgressView()

        case .error(let message):

            Text(message)

        case .success(let data):

            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 16
                ) {

                    BannerCarouselView(
                        banners:
                        data.banners ?? []
                    )

                    greetingSection(
                        user: data.user
                    )

                    menuSection()

                    if let bookings =
                        data.activeBookings,
                       !bookings.isEmpty {

                        activeRideSection(
                            bookings
                        )
                    }

                    bookRideButton()
                }
            }

        default:

            EmptyView()
        }
    }
    
    private func greetingSection(
        user: HomeUser?
    ) -> some View {

        VStack(
            alignment: .leading,
            spacing: 4
        ) {

            Text(
                "Good Morning, \(user?.fullName ?? "")"
            )
            .font(
                .notoSansBold(20)
            )

            Text(
                "Where is your child going today?"
            )
            .font(
                .notoSansMedium(13)
            )
            .foregroundColor(
                .textSecondary
            )
        }
        .padding(.horizontal)
    }

    private func menuSection()
    -> some View {

        LazyVGrid(
            columns:
            Array(
                repeating:
                    GridItem(.flexible()),
                count: 4
            )
        ) {

            HomeGridItemView(
                image: "ic_book_van",
                title: "Bookings"
            ) {
                navigateToBookings = true
            }

            HomeGridItemView(
                image:
                    "ic_child",
                title:
                    "Children"
            ) {
                navigateToChildren = true
            }

            HomeGridItemView(
                image:
                    "ic_address",
                title:
                    "Address"
            ) {
                navigateToAddress = true
            }

            HomeGridItemView(
                image:
                    "ic_person",
                title:
                    "Profile"
            ) {
                navigateToProfile = true
            }
        }
        .padding(.horizontal)
    }

    private func activeRideSection(
        _ bookings:
        [Booking]
    ) -> some View {

        VStack(
            alignment: .leading
        ) {

            Text("Active Rides")
                .font(
                    .notoSansBold(16)
                )
                .padding(.horizontal)

            ScrollView(
                .horizontal,
                showsIndicators:
                    false
            ) {

                HStack {

                    ForEach(
                        bookings
                    ) { booking in

                        ActiveRideCardView(
                            booking:
                            booking
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private func bookRideButton()
    -> some View {

        Button {
            navigateToAddBookings = true
        } label: {

            Text(
                "Book a Ride"
            )
            .font(
                .notoSansBold(16)
            )
            .foregroundColor(
                .white
            )
            .frame(
                maxWidth: .infinity
            )
            .frame(height: 52)
            .background(
                Color.theme
            )
            .cornerRadius(12)
        }
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
}

#Preview {

    HomeView()
}
