//
//  AddressView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI

struct AddressView: View {

    @Environment(\.dismiss)
    private var dismiss

    @StateObject
    private var viewModel =
    AddressViewModel()

    @State private var navigateAddAddress = false

    @State private var selectedAddress:
    BookingAddresses?

    @State private var showDeleteAlert = false

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            VStack(spacing: 0) {

                headerView

                content
            }

            addButton
        }
        .navigationBarBackButtonHidden(true)

        .navigationDestination(
            isPresented:
                $navigateAddAddress
        ) {

            AddressAddView()
        }

        .task {

            viewModel.getAddresses()
        }

//        .onChange(
//            of: viewModel.state
//        ) { _, state in
//
//            switch state {
//
//            case .deleteSuccess:
//
//                viewModel.getAddresses()
//
//            default:
//                break
//            }
//        }

        .alert(
            "Delete Address",
            isPresented:
                $showDeleteAlert
        ) {

            Button(
                "Delete",
                role: .destructive
            ) {

                if let id =
                    selectedAddress?.id {

                    viewModel
                        .deleteAddress(
                            addressId: id
                        )
                }
            }

            Button(
                "Cancel",
                role: .cancel
            ) { }

        } message: {

            Text(
                "Are you sure you want to delete this address?"
            )
        }

        .overlay {

            if case .loading =
                viewModel.state {

                ZStack {

                    Color.black.opacity(0.2)

                    ProgressView()
                }
                .ignoresSafeArea()
            }
        }
    }
}

// MARK: Header

extension AddressView {

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
                .font(
                    .plexSansMedium(18)
                )

            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(Color.lightBlue)
    }
}

// MARK: Content

extension AddressView {

    @ViewBuilder
    private var content: some View {

        if viewModel.addresses.isEmpty {

            VStack {

                Spacer()

                Text(
                    "No Address Added"
                )
                .font(
                    .notoSansBold(16)
                )

                Spacer()
            }

        } else {

            ScrollView {

                LazyVStack(
                    spacing: 12
                ) {

                    ForEach(
                        viewModel.addresses
                    ) { address in

                        AddressCardView(
                            address: address,
                            onDelete: {

                                selectedAddress =
                                address

                                showDeleteAlert =
                                true
                            }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                .padding(.bottom, 100)
            }
            .refreshable {

                viewModel
                    .getAddresses()
            }
        }
    }
}

// MARK: Add Button

extension AddressView {

    private var addButton: some View {

        Button {

            navigateAddAddress = true

        } label: {

            Image(
                systemName:
                "plus"
            )
            .font(.title2)
            .foregroundColor(.white)
            .frame(
                width: 56,
                height: 56
            )
            .background(
                Color.theme
            )
            .clipShape(
                Circle()
            )
        }
        .padding()
    }
}

// MARK: Address Card

struct AddressCardView: View {

    let address:
    BookingAddresses

    let onDelete:
    () -> Void

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            HStack {

                Text(
                    address.addressTitle
                )
                .font(
                    .notoSansBold(14)
                )
                .foregroundColor(
                    .theme
                )

                Spacer()

                Button {

                    onDelete()

                } label: {

                    Image(
                        systemName:
                        "trash"
                    )
                    .foregroundColor(
                        .red
                    )
                }
            }

            row(
                title: "Address",
                value: address.address
            )

            row(
                title: "House",
                value: address.city
            )

            row(
                title: "Pincode",
                value: address.pinCode
            )

            row(
                title: "Landmark",
                value:
                address.landmark ?? "-"
            )

            Text("Location")
                .font(
                    .notoSansBold(12)
                )
                .foregroundColor(
                    .theme
                )
        }
        .padding()
        .background(
            Color.white
        )
        .cornerRadius(20)
        .shadow(
            color:
            .black.opacity(0.08),
            radius: 3
        )
    }

    private func row(
        title: String,
        value: String
    ) -> some View {

        HStack(
            alignment: .top
        ) {

            Text(
                "\(title):"
            )
            .font(
                .notoSansBold(12)
            )

            Text(value)
                .font(
                    .notoSansMedium(12)
                )

            Spacer()
        }
    }
}
