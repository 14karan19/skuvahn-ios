//
//  LiveTrackingView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI
import MapKit

struct LiveTrackingView: View {

    let booking: Boooking

    @Environment(\.dismiss)
    private var dismiss

    @StateObject
    private var viewModel =
    LiveTrackingViewModel()

    @State private var region =
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 28.6139,
            longitude: 77.2090
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01
        )
    )

    @State private var vehicleLocation:
    CLLocationCoordinate2D?

    @State private var timer:
    Timer?

    var body: some View {

        ZStack {
            Map(
                coordinateRegion: $region,
                annotationItems: vehicleLocation == nil
                    ? []
                    : [MapVehicle(location: vehicleLocation!)]
            ) { item in

                MapMarker(
                    coordinate: item.location
                )
            }

            VStack {

                headerView

                Spacer()
            }

            if case .loading =
                viewModel.state {

                ProgressView()
            }
        }
        .navigationBarBackButtonHidden(true)

        .onAppear {

            startTracking()
        }

        .onDisappear {

            timer?.invalidate()
        }

        .onReceive(
            viewModel.$vehicle
        ) { vehicle in

            guard let vehicle else {
                return
            }

            let coordinate =
            CLLocationCoordinate2D(
                latitude: vehicle.lat,
                longitude: vehicle.lon
            )

            vehicleLocation = coordinate

            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01
                )
            )
        }
    }
}

extension LiveTrackingView {

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

            Text("Live Tracking")
                .font(
                    .plexSansMedium(18)
                )

            Spacer()
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(
            Color.lightBlue
        )
    }

    private func startTracking() {

        loadLocation()

        timer =
        Timer.scheduledTimer(
            withTimeInterval: 10,
            repeats: true
        ) { _ in

            loadLocation()
        }
    }

    private func loadLocation() {

        guard let camera =
            booking.camera,

              let cameraNumber =
                camera.cameraNumber,

              let cameraKey =
                camera.cameraKey

        else {
            return
        }

        viewModel.getLiveLocation(
            terminalNo:
            cameraNumber,

            key:
            cameraKey
        )
    }
}
