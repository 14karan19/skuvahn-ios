//
//  VideoTest.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import Foundation
import ZFPlayer

#if !targetEnvironment(simulator)

final class VideoTest:
    NSObject,
    GetPlayURLSocketDataPushDataDelegate {

    let socket = GetPlayURLScoketClientTool()
    
    override init() {
        
        super.init()

        socket.socketDataDelegate = self

        socket.socketClientStart(
            "y.gpstracktech.com",
            onPort: 8900
        )

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 2
        ) {
            self.socket.playLiveVideo(
                "15770008571",
                channel: 1,
                toKen: "43e99764-c83f-40ff-9791-a2ef85301ee7",
                username: "15770008571",
                languageCode: "en"
            )
        }
    }

    @objc(FLVURLCallback:)
    func flvurlCallback(_ url: String!) {
        print("VIDEO URL")
        print(url ?? "")
    }

    @objc(DeviceStatus:)
    func deviceStatus(
        _ data: [AnyHashable: Any]!
    ) {
        print("STATUS")
        print(data ?? [:])
    }

    @objc(socketDidDisconnect)
    func socketDidDisconnect() {
        print("Disconnected")
    }
}
#endif
