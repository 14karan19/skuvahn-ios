//
//  MailView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {

    let recipient: String
    let subject: String

    func makeUIViewController(
        context: Context
    ) -> MFMailComposeViewController {

        let vc =
        MFMailComposeViewController()

        vc.setToRecipients(
            [recipient]
        )

        vc.setSubject(subject)

        return vc
    }

    func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: Context
    ) { }
}
