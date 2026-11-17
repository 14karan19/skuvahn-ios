//
//  ImageCompressor.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import UIKit

enum ImageCompressor {

    static func compress(
        image: UIImage
    ) -> Data? {

        image.jpegData(
            compressionQuality: 0.7
        )
    }
}
