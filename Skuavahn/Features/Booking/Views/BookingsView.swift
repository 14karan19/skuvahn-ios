//
//  BookingsView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import SwiftUI

struct BookingsView: View {

    @Environment(\.dismiss)
    private var dismiss

    @StateObject
    private var viewModel =
    BookingViewModel()

    @State private var navigateToAddBooking = false

    @State
    private var selectedBooking: Boooking?

    @State
    private var navigateToDetails = false

    var body: some View {

        ZStack {

            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {

                headerView

                contentView
            }

            VStack {

                Spacer()

                HStack {

                    Spacer()

                    Button {
                        navigateToAddBooking = true
                    } label: {

                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.theme)
                            .clipShape(Circle())
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)

        .onAppear {

            viewModel.getBookings()
        }

        .navigationDestination(
            isPresented: $navigateToAddBooking
        ) {
            BookingAddView()
        }

        .navigationDestination(
            isPresented:
                $navigateToDetails
        ) {

            if let booking =
                selectedBooking {
                BookingDetailsView(
                    booking: booking
                )
            }
        }

        .refreshable {

            viewModel.getBookings()
        }

        .onReceive(viewModel.$state) { state in

            if case .createSuccess = state {

                viewModel.getBookings()
            }
        }
    }
}

extension BookingsView {

    private var headerView: some View {

        HStack {

            Button {

                dismiss()

            } label: {

                Image(
                    systemName:
                    "chevron.left"
                )
                .foregroundColor(
                    .black
                )
            }

            Text("Bookings")
                .font(
                    .plexSansMedium(18)
                )

            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(Color.lightBlue)
    }

    @ViewBuilder
    private var contentView: some View {

        switch viewModel.state {

        case .loading:

            Spacer()

            ProgressView()

            Spacer()

        case .error(let message):

            Spacer()

            Text(message)

            Spacer()

        case .success(let bookings):

            if bookings.isEmpty {

                emptyView

            } else {

                bookingList(
                    bookings
                )
            }

        default:

            Spacer()
        }
    }

    private var emptyView: some View {

        VStack {

            Spacer()

            Text(
                "No Bookings Found"
            )
            .font(
                .plexSansMedium(16)
            )

            Spacer()
        }
    }

    private func bookingList(
        _ bookings: [Boooking]
    ) -> some View {

        ScrollView {

            LazyVStack {

                ForEach(bookings) { booking in

                    BookingRowView(
                        booking: booking
                    )
                    .onTapGesture {

                        selectedBooking = booking
                        navigateToDetails = true
                    }
                }
            }
            .padding(.top, 8)
        }
    }
    
//    private func bookingList(
//        _ bookings: [Boooking]
//    ) -> some View {
//
//        ScrollView {
//
//            LazyVStack {
//
//                ForEach(bookings) {
//                    booking in
//
//                    BookingRowView(
//                        booking: booking
//                    )
//                    .onTapGesture {
//
//                        selectedBooking =
//                        booking
//
//                        navigateToDetails =
//                        true
//                    }
//                }
//            }
//            .padding(.top, 8)
//        }
//        .overlay(
//            alignment:
//            .bottomTrailing
//        ) {
//
//            Button {
//                navigateToAddBooking = true
//            } label: {
//
//                Image(
//                    systemName:
//                    "plus"
//                )
//                .foregroundColor(
//                    .white
//                )
//                .frame(
//                    width: 56,
//                    height: 56
//                )
//                .background(
//                    Color.theme
//                )
//                .clipShape(
//                    Circle()
//                )
//            }
//            .padding()
//        }
//    }
}

#Preview {

    NavigationStack {

        BookingsView()
    }
}
