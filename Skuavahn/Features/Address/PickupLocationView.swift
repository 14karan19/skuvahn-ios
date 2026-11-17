//
//  PickupLocationView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI
import MapKit
import CoreLocation

struct PickupLocationResult {

    let address: String

    let latitude: String

    let longitude: String

    let city: String

    let state: String

    let locality: String

    let pincode: String
}

struct PickupLocationView: View {

    @Environment(\.dismiss)
    private var dismiss

    let onLocationSelected:
    (PickupLocationResult) -> Void

    @StateObject
    private var locationManager =
    LocationManager()

    @State private var cameraPosition =
    MapCameraPosition.region(
        MKCoordinateRegion(
            center:
                CLLocationCoordinate2D(
                    latitude: 28.6139,
                    longitude: 77.2090
                ),
            span:
                MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01
                )
        )
    )

    @State private var searchText = ""

    @State private var selectedCoordinate:
    CLLocationCoordinate2D?

    @State private var selectedAddress =
    "Move map to select location"

    var body: some View {

        ZStack {

            Map(
                position: $cameraPosition
            )
            .onMapCameraChange(
                frequency: .continuous
            ) { context in

                selectedCoordinate =
                context.region.center
            }

            Image(
                systemName:
                    "mappin.circle.fill"
            )
            .font(
                .system(size: 44)
            )
            .foregroundColor(.red)

            VStack(spacing: 0) {

                headerView

                searchView

                Spacer()

                saveButton
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {

            if let location =
                locationManager.location {

                cameraPosition =
                .region(
                    MKCoordinateRegion(
                        center:
                            location.coordinate,
                        span:
                            MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                    )
                )
            }
        }
    }
}

extension PickupLocationView {

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

            Text("Pickup Location")
                .font(.plexSansMedium(18))

            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(Color.lightBlue)
    }

    private var searchView: some View {

        VStack {

            TextField(
                "Search location",
                text: $searchText
            )
            .padding()
            .background(Color.white)
            .cornerRadius(10)

            Text(selectedAddress)
                .font(.caption)
                .foregroundColor(.black)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
        }
        .padding()
        .background(Color.white.opacity(0.95))
    }

    private var saveButton: some View {

        Button {

            saveLocation()

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
                .background(Color.theme)
                .cornerRadius(8)
        }
        .padding()
        .background(Color.white)
    }

    private func saveLocation() {

        guard let coordinate =
            selectedCoordinate
        else {
            return
        }

        let location =
        CLLocation(
            latitude:
                coordinate.latitude,
            longitude:
                coordinate.longitude
        )

        CLGeocoder()
            .reverseGeocodeLocation(
                location
            ) { placemarks, error in

                guard let place =
                    placemarks?.first
                else {
                    return
                }

                let address =
                [
                    place.name,
                    place.locality,
                    place.administrativeArea
                ]
                    .compactMap { $0 }
                    .joined(separator: ", ")

                onLocationSelected(
                    PickupLocationResult(
                        address:
                            address,

                        latitude:
                            "\(coordinate.latitude)",

                        longitude:
                            "\(coordinate.longitude)",

                        city:
                            place.locality ?? "",

                        state:
                            place.administrativeArea ?? "",

                        locality:
                            place.subLocality ?? "",

                        pincode:
                            place.postalCode ?? ""
                    )
                )

                dismiss()
            }
    }
}
