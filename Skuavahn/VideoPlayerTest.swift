//
//  VideoPlayerTest.swift
//  Skuavahn
//
//  Created by Karan Lamba on 21/06/26.
//

import SwiftUI
import AVKit

struct VideoPlayerTest: View {

    @State private var player: AVPlayer?

    var body: some View {

        VideoPlayer(
            player: player
        )
        .onAppear {

            let url = URL(
                string: "http://sample.vodobox.net/flv/flv_test_700kb.flv"
            )!

            player = AVPlayer(url: url)

            player?.play()
        }
    }
}
