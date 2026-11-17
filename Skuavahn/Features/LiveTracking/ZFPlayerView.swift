//
//  ZFPlayerView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI
import UIKit
import ZFPlayer

struct ZFPlayerView:
UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(
        context: Context
    ) -> PlayerController {

        PlayerController(
            url: url
        )
    }

    func updateUIViewController(
        _ controller: PlayerController,
        context: Context
    ) {

        controller.updateUrl(
            url
        )
    }
}
