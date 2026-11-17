//
//  VideoPlayerViewController.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import UIKit
import ZFPlayer

final class VideoPlayerViewController: UIViewController {

    private var player: ZFPlayerController?

    override func viewDidLoad() {
        super.viewDidLoad()

        let container = UIView(frame: CGRect(
            x: 0,
            y: 100,
            width: view.bounds.width,
            height: 250
        ))

        view.addSubview(container)

        let manager = ZFAVPlayerManager()

        let player = ZFPlayerController(
            playerManager: manager,
            containerView: container
        )

        player.controlView = ZFPlayerControlView()

        self.player = player

        manager.assetURL = URL(
            string: "https://y.gpstracktech.com:8698/cluster1/15770008571_1_0_3874350E05ED42E2B9CF8027CF22AA15_-1_2_1_0_0_0.flv"
        )
    }
}
