//
//  ImagePicker.swift
//  Skuavahn
//
//  Created by Karan Lamba on 18/06/26.
//

import SwiftUI
import PhotosUI

struct ImagePicker:
UIViewControllerRepresentable {

    @Binding
    var image: UIImage?

    func makeCoordinator()
    -> Coordinator {

        Coordinator(self)
    }

    func makeUIViewController(
        context: Context
    ) -> UIImagePickerController {

        let picker =
        UIImagePickerController()

        picker.delegate =
        context.coordinator

        return picker
    }

    func updateUIViewController(
        _ uiViewController:
        UIImagePickerController,
        context: Context
    ) {
    }

    final class Coordinator:
    NSObject,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {

        let parent:
        ImagePicker

        init(
            _ parent:
            ImagePicker
        ) {

            self.parent =
            parent
        }

        func imagePickerController(
            _ picker:
            UIImagePickerController,

            didFinishPickingMediaWithInfo info:
            [UIImagePickerController.InfoKey : Any]
        ) {

            if let image =
                info[.originalImage]
                as? UIImage {

                parent.image =
                image
            }

            picker.dismiss(
                animated: true
            )
        }
    }
}
