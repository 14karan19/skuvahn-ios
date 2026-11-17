//
//  ChildRowView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import SwiftUI

struct ChildRowView: View {

    let child: Children

    let onEdit: () -> Void

    let onDelete: () -> Void

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {

            HStack {

                AsyncImage(
                    url:
                        URL(
                            string:
                                child.imageUrl ?? ""
                        )
                ) { image in

                    image
                        .resizable()

                } placeholder: {

                    Image(
                        "ic_user_placeholder"
                    )
                    .resizable()
                }
                .frame(
                    width: 40,
                    height: 40
                )
                .clipShape(
                    Circle()
                )

                VStack(
                    alignment: .leading
                ) {

                    Text(
                        child.fullName ?? ""
                    )
                    .font(
                        .notoSansBold(14)
                    )
                    .foregroundColor(
                        .theme
                    )

                    Text(
                        child.formattedDob
                    )
                    .font(
                        .notoSansMedium(11)
                    )
                }

                Spacer()
            }

            Divider()

            row(
                title: "School",
                value:
                    child.schoolName ?? "-"
            )

            row(
                title: "Grade",
                value:
                    "\(child.studentClass ?? "") - \(child.section ?? "")"
            )

            Text(
                "Emergency Contact:"
            )
            .font(
                .plexSansBold(11)
            )
            .foregroundColor(
                .redError
            )

            row(
                title: "Name",
                value:
                    child.emergencyContactName ?? "-"
            )

            row(
                title: "Phone",
                value:
                    child.emergencyContactPhone ?? "-"
            )

            Divider()

            HStack {

                Button(
                    "Edit"
                ) {

                    onEdit()
                }
                .frame(
                    maxWidth:
                        .infinity
                )
                .frame(height: 32)
                .background(
                    Color.theme
                )
                .foregroundColor(
                    .white
                )
                .cornerRadius(12)

                Button(
                    "Delete"
                ) {

                    onDelete()
                }
                .frame(
                    maxWidth:
                        .infinity
                )
                .frame(height: 32)
                .background(
                    Color.red
                )
                .foregroundColor(
                    .white
                )
                .cornerRadius(12)
            }
        }
        .padding()
        .background(
            Color.white
        )
        .cornerRadius(20)
        .shadow(
            color:
                .black.opacity(0.1),
            radius: 3
        )
        .padding(
            .horizontal
        )
        .padding(
            .vertical,
            4
        )
    }

    private func row(
        title: String,
        value: String
    ) -> some View {

        HStack {

            Text("\(title):")
                .font(
                    .notoSansBold(11)
                )

            Text(value)
                .font(
                    .notoSansMedium(10)
                )

            Spacer()
        }
    }
}
