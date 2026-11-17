//
//  LiveVideoViewModel.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import Foundation
import Combine

@MainActor
final class LiveVideoViewModel:
NSObject,
ObservableObject {

    @Published var videoUrl: URL?

    @Published var selectedChannel = 1

    // VideoSdk.framework is device-only (arm64 iPhoneOS, no simulator slice),
    // so live video is compiled out of Simulator builds.
#if !targetEnvironment(simulator)
    private let socket =
    GetPlayURLScoketClientTool()
#endif

    override init() {

        super.init()

#if !targetEnvironment(simulator)
        socket.socketDataDelegate = self

        socket.socketClientStart(
            "y.gpstracktech.com",
            onPort: 8900
        )
#else
        print("ℹ️ Live video is unavailable in the Simulator (VideoSdk has no simulator build)")
#endif
    }

    func openChannel(
        cameraNumber: String,
        cameraKey: String,
        channel: Int32
    ) {

        selectedChannel = Int(channel)

#if !targetEnvironment(simulator)
        socket.playLiveVideo(
            cameraNumber,
            channel: channel,
            toKen: cameraKey,
            username: cameraNumber,
            languageCode: "en"
        )
#endif
    }

#if !targetEnvironment(simulator)
//    @objc(FLVURLCallback:)
//    func flvURLCallback(
//        _ url: String!
//    ) {
//
//        print("VIDEO URL")
//        print(url ?? "")
//
//        videoUrl =
//        URL(string: url)
//    }

    @objc(DeviceStatus:)
    func deviceStatus(
        _ data: [AnyHashable : Any]!
    ) {

        print(data ?? [:])
    }

    @objc(socketDidDisconnect)
    func socketDidDisconnect() {

        print("Disconnected")
    }

    deinit {

        socket.socketCloseClient()
    }
#endif
}

#if !targetEnvironment(simulator)
extension LiveVideoViewModel:
GetPlayURLSocketDataPushDataDelegate {}
#endif
