//
//  AddressAddView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI

struct AddressAddView: View {

    @Environment(\.dismiss)
    private var dismiss

    @StateObject
    private var viewModel =
    AddressViewModel()

    @State private var navigatePickupLocation = false

    @State private var houseNumber = ""

    @State private var city = ""

    @State private var state = ""

    @State private var landmark = ""

    @State private var selectedAddress = ""

    @State private var latitude = ""

    @State private var longitude = ""

    @State private var locality = ""

    @State private var pincode = ""

    @State private var addressType = "Home"

    private let addressTypes =
    [
        "Home",
        "Work",
        "Other"
    ]

    private var isValid: Bool {

        !houseNumber.isEmpty &&
        !city.isEmpty &&
        !state.isEmpty &&
        !latitude.isEmpty &&
        !longitude.isEmpty
    }

    var body: some View {

        VStack(spacing: 0) {

            headerView

            ScrollView {

                VStack(spacing: 14) {

                    TextField(
                        "Flat / House no / Floor",
                        text: $houseNumber
                    )
                    .fieldStyle()

                    TextField(
                        "City",
                        text: $city
                    )
                    .fieldStyle()

                    TextField(
                        "State",
                        text: $state
                    )
                    .fieldStyle()

                    TextField(
                        "Nearby Landmark (Optional)",
                        text: $landmark
                    )
                    .fieldStyle()

                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {

                        Text("Selected Address")
                            .font(.notoSansBold(13))

                        Text(
                            selectedAddress.isEmpty
                            ? "No location selected"
                            : selectedAddress
                        )
                        .font(.notoSansMedium(13))
                        .foregroundColor(.gray)

                        Button {

                            navigatePickupLocation = true

                        } label: {

                            Text("Pickup Location")
                                .font(
                                    .plexSansSemiBold(14)
                                )
                                .foregroundColor(
                                    .theme
                                )
                        }
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

                    VStack(
                        alignment: .leading
                    ) {

                        Text("Address Type")
                            .font(.notoSansBold(13))

                        Picker(
                            "",
                            selection: $addressType
                        ) {

                            ForEach(
                                addressTypes,
                                id: \.self
                            ) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    saveButton
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)

        .navigationDestination(
            isPresented:
                $navigatePickupLocation
        ) {

            PickupLocationView {

                result in

                selectedAddress =
                result.address

                latitude =
                result.latitude

                longitude =
                result.longitude

                city =
                result.city

                state =
                result.state

                locality =
                result.locality

                pincode =
                result.pincode
            }
        }

        .onChange(
            of: viewModel.state
        ) { _, state in

            switch state {

            case .addSuccess:
                dismiss()

            default:
                break
            }
        }

        .overlay {

            if case .loading =
                viewModel.state {

                ZStack {

                    Color.black.opacity(0.2)

                    ProgressView()
                }
            }
        }
    }
}

extension AddressAddView {

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

            Text("Address")
                .font(.plexSansMedium(18))

            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(Color.lightBlue)
    }

    private var saveButton: some View {

        Button {

            let request =
            AddAddressRequest(
                addressType:
                addressType,

                latitude:
                latitude,

                longitude:
                longitude,

                locality:
                locality,

                city:
                city,

                state:
                state,

                fullAddress:
                houseNumber,

                landmark:
                landmark.isEmpty
                ? nil
                : landmark,

                pincode:
                pincode,

                userId:
                AppPref.shared.userId
            )

            viewModel.addAddress(
                request:
                request
            )

        } label: {

            Text("Save Address")
                .font(
                    .plexSansSemiBold(15)
                )
                .foregroundColor(.white)
                .frame(
                    maxWidth: .infinity
                )
                .frame(height: 48)
        }
        .background(
            isValid
            ? Color.theme
            : Color.disableColor
        )
        .cornerRadius(8)
        .disabled(!isValid)
    }
}

private extension View {

    func fieldStyle() -> some View {

        self
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
    }
}
