//
//  ChildrenView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import SwiftUI

struct ChildrenView: View {

    @Environment(\.dismiss)
    private var dismiss

    @StateObject
    private var viewModel =
    ChildViewModel()

    @State
    private var navigateToAddChild = false

    @State
    private var selectedChild: Children?

    @State
    private var childToDelete: Children?

    var body: some View {

//        ZStack {
//
//            Color.white
//                .ignoresSafeArea()
//
//            VStack(spacing: 0) {
//
//                headerView
//
//                contentView
//            }
//        }
        

        ZStack {

            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {

                headerView

                contentView
            }

            VStack {

                Spacer()

                HStack {

                    Spacer()

                    Button {
                        selectedChild = nil
                        navigateToAddChild = true
                    } label: {

                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.theme)
                            .clipShape(Circle())
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
        .onAppear {

            viewModel.getChildren()
        }

        .navigationDestination(
            isPresented: $navigateToAddChild
        ) {
            ChildAddView(
                child: selectedChild
            )
        }
        
        .alert(
            "Delete Child",
            isPresented:
                Binding(
                    get: {
                        childToDelete != nil
                    },
                    set: { value in
                        if !value {
                            childToDelete = nil
                        }
                    }
                )
        ) {

            Button(
                "Cancel",
                role: .cancel
            ) {}

            Button(
                "Delete",
                role: .destructive
            ) {

                if let id =
                    childToDelete?.id {

                    viewModel
                        .deleteChild(
                            childId: id
                        )
                }
            }

        } message: {

            Text(
                "Are you sure you want to delete this child?"
            )
        }

        .refreshable {

            viewModel.getChildren()
        }

        .overlay {

            if case .loading =
                viewModel.state {

                ProgressView()
                    .scaleEffect(1.2)
            }
        }
    }
}

extension ChildrenView {

    private var headerView: some View {

        HStack {

            Button {

                dismiss()

            } label: {

                Image(
                    systemName:
                        "chevron.left"
                )
                .foregroundColor(
                    .black
                )
            }

            Text("Children")
                .font(
                    .plexSansMedium(18)
                )

            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(
            Color.lightBlue
        )
    }

    @ViewBuilder
    private var contentView: some View {

        switch viewModel.state {

        case .success(let children):

            if children.isEmpty {
                emptyView
            } else {
                listView(children)
            }

        case .loading:

            Spacer()

            ProgressView()

            Spacer()

        case .error(let message):

            Spacer()

            Text(message)

            Spacer()

        default:

            Spacer()
        }
    }

    private var emptyView: some View {

        VStack {

            Spacer()

            Text(
                "No Child Added"
            )
            .font(
                .plexSansMedium(16)
            )

            Spacer()
        }
    }

    private func listView(
        _ children: [Children]
    ) -> some View {

        ScrollView {

            LazyVStack {

                ForEach(children) { child in

                    ChildRowView(
                        child: child,
                        onEdit: {
                            selectedChild = child
                            navigateToAddChild = true
                        },
                        onDelete: {
                            childToDelete = child
                        }
                    )
                }
            }
            .padding(.top, 8)
        }
    }
    
//    private func listView(
//        _ children: [Children]
//    ) -> some View {
//
//        ScrollView {
//
//            LazyVStack {
//
//                ForEach(children) {
//                    child in
//
//                    ChildRowView(
//                        child: child,
//
//                        onEdit: {
//
//                            selectedChild =
//                            child
//
//                            navigateToAddChild = true
//                        },
//
//                        onDelete: {
//
//                            childToDelete =
//                            child
//                        }
//                    )
//                }
//            }
//            .padding(.top, 8)
//        }
//        .overlay(
//            alignment:
//                .bottomTrailing
//        ) {
//
//            Button {
//                selectedChild = nil
//
//                navigateToAddChild = true
//            } label: {
//
//                Image(
//                    systemName:
//                        "plus"
//                )
//                .foregroundColor(
//                    .white
//                )
//                .frame(
//                    width: 56,
//                    height: 56
//                )
//                .background(
//                    Color.theme
//                )
//                .clipShape(
//                    Circle()
//                )
//            }
//            .padding()
//        }
//    }
}
