//
//  ActiveRideCardView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

struct ActiveRideCardView: View {

    let booking: Booking

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 6
        ) {

            Text(
                booking.child.fullName
            )
            .font(
                .notoSansBold(14)
            )
            .foregroundColor(
                .theme
            )

            info(
                "Address:",
                booking.address.locality
            )

            info(
                "School:",
                booking.school.name
            )

            info(
                "Driver:",
                booking.captain?.fullName ?? "-"
            )

            info(
                "Phone:",
                booking.captain?.phone ?? "-"
            )

            Divider()

            Button {

                print(
                    "Track Booking"
                )

            } label: {

                Text("Track")
                    .font(
                        .notoSansBold(13)
                    )
                    .foregroundColor(
                        .white
                    )
                    .frame(
                        maxWidth: .infinity
                    )
                    .frame(height: 34)
                    .background(
                        Color.theme
                    )
                    .cornerRadius(16)
            }
        }
        .padding()
        .frame(width: 280)
        .background(.white)
        .cornerRadius(20)
        .shadow(
            color:
                .black.opacity(0.05),
            radius: 4
        )
    }

    @ViewBuilder
    private func info(
        _ title: String,
        _ value: String
    ) -> some View {

        HStack(
            alignment: .top,
            spacing: 4
        ) {

            Text(title)
                .font(
                    .notoSansBold(11)
                )

            Text(value)
                .font(
                    .notoSansMedium(11)
                )
        }
    }
}
