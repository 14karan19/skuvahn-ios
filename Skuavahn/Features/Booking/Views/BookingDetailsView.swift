//
//  BookingDetailsView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI

struct BookingDetailsView: View {

    @StateObject
    private var liveVm = LiveVideoViewModel()

    @State
    private var navigateTracking = false
    
    let booking: Boooking

    @Environment(\.dismiss)
    private var dismiss

    private var hasCamera: Bool {
        booking.camera != nil &&
        !(booking.camera?.cameraNumber ?? "").isEmpty
    }

    var body: some View {

        VStack(spacing: 0) {

            headerView

            ScrollView {

                VStack(spacing: 0) {

                    if hasCamera {

                        videoSection

                        Divider()
                    }

                    childSection

                    Divider()

                    bookingSection

                    Divider()

                    driverSection

                    if hasCamera {

                        trackingButton
                    }
                }
                .padding(.bottom, 20)
            }
            .onAppear {

                guard let camera = booking.camera else {
                    return
                }

                liveVm.openChannel(
                    cameraNumber: camera.cameraNumber ?? "",
                    cameraKey: camera.cameraKey ?? "",
                    channel: 1
                )
            }
        }
        .navigationBarBackButtonHidden(true)

        .navigationDestination(
            isPresented: $navigateTracking
        ) {

            LiveTrackingView(
                booking: booking
            )
        }
    }
}

// MARK: - Components

extension BookingDetailsView {

    private var videoSection: some View {

        VStack(spacing: 12) {

            if let url = liveVm.videoUrl {

                ZFPlayerView(url: url)
                    .frame(height: 220)

            } else {

                Rectangle()
                    .fill(Color.black)

                    .overlay {

                        VStack(spacing: 8) {

                            ProgressView()

                            Text("Connecting Camera...")
                                .foregroundColor(.white)
                                .font(.notoSansMedium(12))
                        }
                    }
                    .frame(height: 220)
            }

            HStack(spacing: 12) {

                channelButton(
                    title: "Channel 1",
                    channel: 1
                )

                channelButton(
                    title: "Channel 2",
                    channel: 2
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
    }
    
    private func channelButton(
        title: String,
        channel: Int
    ) -> some View {

        Button {

            guard let camera =
                booking.camera
            else {
                return
            }

            liveVm.openChannel(
                cameraNumber:
                    camera.cameraNumber ?? "",

                cameraKey:
                    camera.cameraKey ?? "",

                channel:
                    Int32(channel)
            )

        } label: {

            Text(title)
                .font(.notoSansBold(13))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 38)
                .background(
                    liveVm.selectedChannel == channel
                    ? Color.theme
                    : Color.theme.opacity(0.5)
                )
                .cornerRadius(8)
        }
    }
    
    private var headerView: some View {

        HStack {

            Button {

                dismiss()

            } label: {

                Image(systemName: "chevron.left")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }

            Text("Booking Details")
                .font(.plexSansMedium(18))

            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(Color.lightBlue)
    }

    // MARK: Child Section

    private var childSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            HStack(alignment: .center) {

                AsyncImage(
                    url: URL(
                        string:
                        booking.child?.imageUrl ?? ""
                    )
                ) { image in

                    image
                        .resizable()
                        .scaledToFill()

                } placeholder: {

                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
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
                        booking.child?.fullName ?? "-"
                    )
                    .font(.notoSansBold(18))
                    .foregroundColor(.theme)

                    Text(
                        formatDate(
                            booking.child?.dob
                        )
                    )
                    .font(.notoSansMedium(13))
                    .foregroundColor(.gray)
                }

                Spacer()
            }

            Divider()
                .overlay(Color.theme)

            detailsRow(
                title: "School",
                value:
                booking.school?.name ?? "-"
            )

            detailsRow(
                title: "Grade",
                value:
                "\(booking.child?.studentClass ?? "-") - \(booking.child?.section ?? "-")"
            )

            detailsRow(
                title: "Emergency Contact Name",
                value:
                booking.child?.emergencyContactName ?? "-"
            )

            detailsRow(
                title: "Emergency Contact Phone",
                value:
                booking.child?.emergencyContactPhone ?? "-"
            )
        }
        .padding()
    }

    // MARK: Booking Section

    private var bookingSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Booking Details")
                .font(.notoSansBold(16))

            detailsRow(
                title: "Address",
                value:
                booking.address?.fullAddress ?? "-"
            )

            detailsRow(
                title: "School",
                value:
                booking.school?.name ?? "-"
            )

            detailsRow(
                title: "Date",
                value:
                formatDate(
                    booking.createdAt
                )
            )

            detailsRow(
                title: "Start Date",
                value:
                formatDate(
                    booking.startDate
                )
            )

            detailsRow(
                title: "Tenure",
                value:
                booking.tenure ?? "-"
            )
        }
        .padding()
    }

    // MARK: Driver Section

    private var driverSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            HStack {

                AsyncImage(
                    url: URL(
                        string:
                        booking.captain?.imageUrl ?? ""
                    )
                ) { image in

                    image
                        .resizable()
                        .scaledToFill()

                } placeholder: {

                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.gray)
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
                        booking.captain?.fullName ??
                        "Not Assigned"
                    )
                    .font(.notoSansBold(18))
                    .foregroundColor(.theme)

                    Text(
                        booking.vehicle?.registrationNumber ??
                        "-"
                    )
                    .font(.notoSansMedium(13))

                    Text(
                        booking.captain?.phone ??
                        "-"
                    )
                    .font(.notoSansMedium(13))
                }

                Spacer()
            }
        }
        .padding()
    }

    // MARK: Tracking Button

    private var trackingButton: some View {

        Button {

            navigateTracking = true

        } label: {

            Text("Live Tracking")
                .font(.plexSansSemiBold(15))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }
        .background(Color.theme)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.top, 20)
    }

    // MARK: Details Row

    private func detailsRow(
        title: String,
        value: String
    ) -> some View {

        HStack(alignment: .top) {

            Text("\(title):")
                .font(.notoSansBold(13))
                .foregroundColor(.gray)

            Text(value)
                .font(.notoSansMedium(13))
                .foregroundColor(.black)

            Spacer()
        }
    }
}

// MARK: - Date Formatter

extension BookingDetailsView {

    private func formatDate(
        _ dateString: String?
    ) -> String {

        guard let dateString,
              !dateString.isEmpty else {
            return "-"
        }

        let formats = [

            "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss"
        ]

        let parser = DateFormatter()

        parser.locale =
        Locale(identifier: "en_US_POSIX")

        parser.timeZone =
        TimeZone(secondsFromGMT: 0)

        for format in formats {

            parser.dateFormat = format

            if let date =
                parser.date(
                    from: dateString
                ) {

                let output =
                DateFormatter()

                output.dateFormat =
                "dd MMM yyyy"

                return output.string(
                    from: date
                )
            }
        }

        return "-"
    }
}
