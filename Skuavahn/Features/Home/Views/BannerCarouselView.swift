//
//  BannerCarouselView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI
import Combine

struct BannerCarouselView: View {

    let banners: [Banner]

    @State private var currentIndex = 0

    private let timer =
    Timer.publish(
        every: 3,
        on: .main,
        in: .common
    ).autoconnect()

    var body: some View {

        VStack(spacing: 8) {

            TabView(
                selection: $currentIndex
            ) {

                ForEach(
                    Array(banners.enumerated()),
                    id: \.offset
                ) { index, banner in

                    AsyncImage(
                        url: URL(
                            string:
                            banner.bannerUrl
                        )
                    ) { image in

                        image
                            .resizable()
                            .scaledToFill()

                    } placeholder: {

                        ProgressView()
                    }
                    .frame(height: 240)
                    .clipped()
                    .tag(index)
                }
            }
            .tabViewStyle(
                .page(indexDisplayMode: .never)
            )
            .frame(height: 240)

            if banners.count > 1 {

                HStack(spacing: 8) {

                    ForEach(
                        0..<banners.count,
                        id: \.self
                    ) { index in

                        Circle()
                            .fill(
                                currentIndex == index
                                ? Color.theme
                                : Color.gray.opacity(0.4)
                            )
                            .frame(
                                width: 8,
                                height: 8
                            )
                    }
                }
            }
        }
        .onReceive(timer) { _ in

            guard banners.count > 1
            else { return }

            withAnimation {

                currentIndex =
                (currentIndex + 1)
                % banners.count
            }
        }
    }
}
