//
//  Booking+Extensions.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import Foundation

extension Boooking {

    var formattedCreatedDate: String {

        formatDate(
            createdAt
        )
    }

    var formattedStartDate: String {

        formatDate(
            startDate
        )
    }

    private func formatDate(
        _ value: String?
    ) -> String {

        print(value ?? "")
        
        guard let value,
              !value.isEmpty
        else {
            return "-"
        }

        let inputFormatter =
        ISO8601DateFormatter()

        inputFormatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]

        if let date =
            inputFormatter.date(from: value) {

            let outputFormatter =
            DateFormatter()

            outputFormatter.dateFormat =
            "dd MMM yyyy"

            return outputFormatter.string(
                from: date
            )
        }

        return "-"
    }
    
}
