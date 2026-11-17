//
//  PlayerController.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//
//
// PlayerController.swift
//

import UIKit
import ZFPlayer

final class PlayerController:
UIViewController {

    private var url: URL

    private var player:
    ZFPlayerController?

    private var manager:
    ZFAVPlayerManager?

    init(url: URL) {

        self.url = url

        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = .black

        let container =
        UIView(frame: view.bounds)

        container.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]

        view.addSubview(container)

        let manager =
        ZFAVPlayerManager()

        manager.assetURL = url

        let player =
        ZFPlayerController(
            playerManager: manager,
            containerView: container
        )

        player.controlView =
        ZFPlayerControlView()

        self.manager = manager
        self.player = player
    }

    func updateUrl(
        _ newUrl: URL
    ) {

        guard
            newUrl != url
        else {
            return
        }

        url = newUrl

        manager?.assetURL = newUrl
    }
}
