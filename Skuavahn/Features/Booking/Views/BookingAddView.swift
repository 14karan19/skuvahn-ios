//
//  BookingAddView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI

struct BookingAddView: View {

@Environment(\.dismiss)
private var dismiss

@StateObject
private var viewModel = BookingViewModel()

@State
private var selectedChild: Children?

@State
private var selectedAddress: BookingAddresses?

@State
private var selectedSchool: Schoool?

@State
private var selectedTenure: String?

@State
private var startDate = Date()

@State
private var showChildSheet = false

@State
private var showAddressSheet = false

@State
private var showTenureSheet = false

private let tenures = [
    "1 Month",
    "2 Month",
    "3 Month"
]

private var isValid: Bool {

    selectedChild != nil &&
    selectedAddress != nil &&
    selectedSchool != nil &&
    selectedTenure != nil
}

var body: some View {

    VStack(spacing: 0) {

        headerView

        ScrollView {

            VStack(spacing: 16) {

                childField

                addressField

                schoolField

                tenureField

                startDateField

                createBookingButton
            }
            .padding(.horizontal, 18)
            .padding(.top, 20)
        }
    }
    .background(Color.white)
    .navigationBarBackButtonHidden(true)

    .task {

        viewModel.loadDropdowns()
    }

    .onReceive(viewModel.$state) { state in

        switch state {

        case .createSuccess:

            dismiss()

        default:
            break
        }
    }

    .sheet(
        isPresented: $showChildSheet
    ) {

        NavigationStack {

            List(
                viewModel.children
            ) { child in

                Button {

                    selectedChild =
                    child

                    showChildSheet =
                    false

                } label: {

                    Text(
                        child.fullName ?? ""
                    )
                }
            }
            .navigationTitle(
                "Select Child"
            )
        }
    }

    .sheet(
        isPresented: $showAddressSheet
    ) {

        NavigationStack {

            List(
                viewModel.addresses
            ) { address in

                Button {

                    selectedAddress =
                    address

                    showAddressSheet =
                    false

                } label: {

                    VStack(
                        alignment: .leading,
                        spacing: 4
                    ) {

                        Text(
                            address.addressTitle
                        )
                        .font(
                            .notoSansBold(13)
                        )

                        Text(
                            address.fullAddress ?? ""
                        )
                        .font(
                            .notoSansMedium(11)
                        )
                        .foregroundColor(
                            .gray
                        )
                    }
                }
            }
            .navigationTitle(
                "Select Address"
            )
        }
    }

    .sheet(
        isPresented: $showTenureSheet
    ) {

        NavigationStack {

            List(
                tenures,
                id: \.self
            ) { tenure in

                Button {

                    selectedTenure =
                    tenure

                    showTenureSheet =
                    false

                } label: {

                    Text(
                        tenure
                    )
                }
            }
            .navigationTitle(
                "Select Tenure"
            )
        }
    }

    .overlay {

        if case .loading =
            viewModel.state {

            ProgressView()
                .scaleEffect(1.2)
        }
    }
}

}

// MARK: Header

extension BookingAddView {

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

        Text(
            "Add Booking"
        )
        .font(
            .plexSansMedium(18)
        )

        Spacer()
    }
    .padding(.horizontal, 16)
    .frame(height: 50)
    .background(
        Color.lightBlue
    )
}

}

// MARK: Fields

extension BookingAddView {

private var fieldBackground: some View {

    RoundedRectangle(
        cornerRadius: 12
    )
    .fill(Color.white)
    .overlay(
        RoundedRectangle(
            cornerRadius: 12
        )
        .stroke(
            Color.lightGrayStroke,
            lineWidth: 1
        )
    )
}

private var childField: some View {

    Button {

        showChildSheet = true

    } label: {

        HStack {

            Text(
                selectedChild?.fullName
                ?? "Select Child"
            )

            Spacer()

            Image(
                systemName:
                    "chevron.down"
            )
        }
        .foregroundColor(
            selectedChild == nil
            ? .gray
            : .black
        )
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(
            fieldBackground
        )
    }
}

private var addressField: some View {

    Button {

        showAddressSheet = true

    } label: {

        HStack {

            Text(
                selectedAddress?.fullAddress
                ?? "Select Address"
            )

            Spacer()

            Image(
                systemName:
                    "chevron.down"
            )
        }
        .foregroundColor(
            selectedAddress == nil
            ? .gray
            : .black
        )
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(
            fieldBackground
        )
    }
}

private var schoolField: some View {

    Menu {

        ForEach(
            viewModel.schools
        ) { school in

            Button(
                school.name
            ) {

                selectedSchool =
                school
            }
        }

    } label: {

        HStack {

            Text(
                selectedSchool?.name
                ?? "Select School"
            )

            Spacer()

            Image(
                systemName:
                    "chevron.down"
            )
        }
        .foregroundColor(
            selectedSchool == nil
            ? .gray
            : .black
        )
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(
            fieldBackground
        )
    }
}

private var tenureField: some View {

    Button {

        showTenureSheet = true

    } label: {

        HStack {

            Text(
                selectedTenure
                ?? "Select Tenure"
            )

            Spacer()

            Image(
                systemName:
                    "chevron.down"
            )
        }
        .foregroundColor(
            selectedTenure == nil
            ? .gray
            : .black
        )
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(
            fieldBackground
        )
    }
}

private var startDateField: some View {

    HStack {

        Text(
            "Start Date"
        )

        Spacer()

        DatePicker(
            "",
            selection:
                $startDate,
            displayedComponents:
                .date
        )
        .labelsHidden()
    }
    .padding(.horizontal, 16)
    .frame(height: 56)
    .background(
        fieldBackground
    )
}

}

// MARK: Button

extension BookingAddView {

private var createBookingButton: some View {

    Button {

        createBooking()

    } label: {

        Text(
            "Create Booking"
        )
        .font(
            .plexSansSemiBold(16)
        )
        .foregroundColor(
            .white
        )
        .frame(
            maxWidth: .infinity
        )
        .frame(height: 50)
    }
    .background(
        isValid
        ? Color.theme
        : Color.disableColor
    )
    .cornerRadius(10)
    .disabled(
        !isValid
    )
}

private func createBooking() {

    let formatter =
    ISO8601DateFormatter()

    formatter.formatOptions = [
        .withInternetDateTime,
        .withFractionalSeconds
    ]

    let finalDate =
    formatter.string(
        from: startDate
    )

    viewModel.createBooking(
        childId:
            selectedChild?.id ?? "",

        addressId:
            selectedAddress?.id ?? "",

        schoolId:
            selectedSchool?.id ?? "",

        tenure:
            selectedTenure ?? "",

        startDate:
            finalDate
    )
}

}

#Preview {

NavigationStack {

    BookingAddView()
}

}
