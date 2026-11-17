//
//  Color+Extension.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI

extension Color {

    // MARK: Theme

    static let theme = Color(hex: "#1773BE")

    // MARK: Basic

    static let blackCustom = Color(hex: "#000000")
    static let whiteCustom = Color(hex: "#FFFFFF")

    static let redError = Color(hex: "#8F2F30")
    static let redCustom = Color(hex: "#E60000")

    static let greenCustom = Color(hex: "#90EE90")
    static let orangeCustom = Color(hex: "#F96B00")

    static let darkBlue = Color(hex: "#364986")

    // MARK: Backgrounds

    static let bgCommands = Color(hex: "#E7F4FF")
    static let bgMain = Color(hex: "#F6F8FC")
    static let bgLight = Color(hex: "#F9FAFB")

    static let lightBlue = Color(hex: "#E7F4FF")
    static let lightGreen = Color(hex: "#D0EBE9")
    static let lightOrange = Color(hex: "#FFD580")

    static let cellBackground = Color(hex: "#F8F3F3")

    // MARK: Grays

    static let lightBlack = Color(hex: "#4E4E4E")

    static let darkestGray = Color(hex: "#5C5C5C")
    static let darkGrayCustom = Color(hex: "#8391A1")

    static let lightGrayCustom = Color(hex: "#F7F8F9")
    static let lightGrayStroke = Color(hex: "#E8ECF4")

    static let grayCustom = Color(hex: "#C6C6C6")

    static let disableColor = Color(hex: "#DEDEDE")

    // MARK: OTP

    static let otpFill = Color(hex: "#D9D9D9")
    static let otpStroke = Color(hex: "#D5D8DC")

    // MARK: Text

    static let textPrimary = Color(hex: "#1F2937")
    static let textSecondary = Color(hex: "#6B7280")
    static let textHint = Color(hex: "#9CA3AF")

    // MARK: Status

    static let statusPendingBg = Color(hex: "#FEF3C7")
    static let statusPendingText = Color(hex: "#92400E")

    static let statusCompletedBg = Color(hex: "#DCFCE7")
    static let statusCompletedText = Color(hex: "#166534")

    // MARK: Grey Shades

    static let grey50 = Color(hex: "#FAFAFA")
    static let grey100 = Color(hex: "#F5F5F5")
    static let grey200 = Color(hex: "#EEEEEE")
    static let grey250 = Color(hex: "#E7E7E7")
    static let grey300 = Color(hex: "#E0E0E0")
    static let grey400 = Color(hex: "#BDBDBD")
    static let grey500 = Color(hex: "#9E9E9E")
    static let grey600 = Color(hex: "#757575")
    static let grey700 = Color(hex: "#616161")
    static let grey800 = Color(hex: "#424242")
    static let grey900 = Color(hex: "#212121")
    static let grey1000 = Color(hex: "#545454")

    // MARK: Primary

    static let primary = Color(hex: "#4A6CF7")
    static let primaryDark = Color(hex: "#3A56D4")
    static let accentGreen = Color(hex: "#2ECC71")

    // MARK: Shadow

    static let cardShadow = Color.black.opacity(0.10)
}
