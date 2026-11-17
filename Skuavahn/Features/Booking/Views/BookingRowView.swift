//
//  BookingRowView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import SwiftUI

struct BookingRowView: View {

    let booking: Boooking

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(
                booking.child?.fullName ?? "-"
            )
            .font(
                .notoSansBold(14)
            )
            .foregroundColor(
                .theme
            )

            detailRow(
                title: "Address",
                value:
                booking.address?.locality
                ?? "-"
            )

            detailRow(
                title: "School",
                value:
                booking.school?.name
                ?? "-"
            )

            detailRow(
                title: "Tenure",
                value:
                booking.tenure
                ?? "-"
            )

            detailRow(
                title: "Start Date",
                value:
                booking.formattedStartDate
            )

            detailRow(
                title: "Date",
                value:
                booking.formattedCreatedDate
            )

            Divider()

            HStack {

                Spacer()

                Text(
                    "View Details"
                )
                .font(
                    .notoSansBold(12)
                )
                .foregroundColor(
                    .white
                )
                .frame(
                    maxWidth: .infinity
                )
                .frame(
                    height: 34
                )
                .background(
                    Color.theme
                )
                .cornerRadius(10)
            }
        }
        .padding()
        .background(
            Color.white
        )
        .cornerRadius(20)
        .shadow(
            color:
            .black.opacity(0.1),
            radius: 3
        )
        .padding(.horizontal)
        .padding(.vertical, 4)
    }

    private func detailRow(
        title: String,
        value: String
    ) -> some View {

        HStack {

            Text("\(title):")
                .font(
                    .notoSansBold(11)
                )

            Text(value)
                .font(
                    .notoSansMedium(10)
                )

            Spacer()
        }
    }
}

#Preview {

    BookingRowView(
        booking:
            Boooking(
                id: UUID().uuidString,
                status: 1,
                createdAt: nil,
                tenure: "1 Month",
                startDate: nil,
                child: nil,
                school: nil,
                address: nil,
                route: nil,
                captain: nil,
                vehicle: nil,
                camera: nil
            )
    )
}
