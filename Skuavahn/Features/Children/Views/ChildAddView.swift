//
//  ChildAddView.swift
//  Skuavahn
//
//  Created by Karan Lamba on 20/06/26.
//

import SwiftUI
import PhotosUI

struct ChildAddView: View {

    let child: Children?

    @State private var dataLoaded = false
    
    @Environment(\.dismiss)
    private var dismiss

    @StateObject
    private var viewModel = ChildViewModel()

    init(child: Children? = nil) {
            self.child = child
        }
    
    private var isEditMode: Bool {
        child != nil
    }
    
    @State private var fullName = ""
    @State private var emergencyName = ""
    @State private var emergencyPhone = ""

    @State private var selectedDOB = Date()

    @State private var selectedClass: String?
    @State private var selectedSection: String?
    @State private var selectedSchool: Schoool?

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?

    let classList = [
        "Play School",
        "Pre Nursery",
        "Nursery",
        "LKG",
        "UKG",
        "Class 1",
        "Class 2",
        "Class 3",
        "Class 4",
        "Class 5",
        "Class 6",
        "Class 7",
        "Class 8",
        "Class 9",
        "Class 10",
        "Class 11",
        "Class 12"
    ]

    let sectionList = [
        "A","B","C","D","E",
        "F","G","H","I","J"
    ]

    private var isValid: Bool {

        !fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty
        &&
        selectedClass != nil
        &&
        selectedSection != nil
        &&
        selectedSchool != nil
        &&
        !emergencyName.isEmpty
        &&
        emergencyPhone.count == 10
        &&
        (
            selectedImage != nil
            ||
            !(child?.imageUrl ?? "").isEmpty
        )
    }

    var body: some View {

        VStack(spacing: 0) {

            headerView

            ScrollView {

                VStack(spacing: 16) {

                    profileImageSection

                    nameField

                    classField

                    sectionField

                    dobField

                    schoolField

                    emergencyNameField

                    emergencyPhoneField

                    saveButton
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 30)
            }
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .task {
            viewModel.getSchools()
        }
        .onChange(
            of: selectedItem
        ) { _, item in

            Task {

                if let data =
                    try? await item?.loadTransferable(
                        type: Data.self
                    ),
                   let image =
                    UIImage(data: data) {

                    selectedImage = image
                }
            }
        }
        
        .onReceive(viewModel.$state) { state in

            switch state {

            case .addSuccess,
                 .updateSuccess:

                dismiss()
                
            default:
                break
            }
        }
        
        .onReceive(viewModel.$schools) { schools in

            guard
                let child,
                !dataLoaded,
                !schools.isEmpty
            else {
                return
            }

            dataLoaded = true

            fullName =
            child.fullName ?? ""

            emergencyName =
            child.emergencyContactName ?? ""

            emergencyPhone =
            child.emergencyContactPhone ?? ""

            selectedClass =
            child.studentClass

            selectedSection =
            child.section

            selectedSchool =
            schools.first {
                $0.id.lowercased()
                ==
                (child.schoolId ?? "")
                    .lowercased()
            }

            if let dob = child.dob {

                let formatter = DateFormatter()

                formatter.dateFormat =
                "yyyy-MM-dd'T'HH:mm:ss"

                formatter.locale =
                Locale(identifier: "en_US_POSIX")

                formatter.timeZone =
                TimeZone(identifier: "Asia/Kolkata")

                print(dob)
                
                if let date =
                    formatter.date(from: dob) {

                    selectedDOB =
                    Calendar.current.startOfDay(
                        for: date
                    )
                }
                
                print(selectedDOB)
            }

            loadImageFromUrl()
        }
    }
}

// MARK: Header

extension ChildAddView {

    private func loadImageFromUrl() {

        guard
            let imageUrl =
                child?.imageUrl,
            let url =
                URL(string: imageUrl)
        else {
            return
        }

        Task {

            do {

                let (data, _) =
                try await URLSession.shared
                    .data(from: url)

                if let image =
                    UIImage(data: data) {

                    await MainActor.run {

                        selectedImage =
                        image
                    }
                }

            } catch {

                print(error)
            }
        }
    }
    
    private var headerView: some View {

        HStack {

            Button {

                dismiss()

            } label: {

                Image(
                    systemName:
                        "chevron.left"
                )
                .foregroundColor(.black)
            }

            Text(
                isEditMode
                ? "Update Child"
                : "Add Child"
            ).font(
                    .plexSansMedium(18)
                )

            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(Color.lightBlue)
    }
}

// MARK: Profile

extension ChildAddView {

    private var profileImageSection: some View {

        ZStack(alignment: .bottomTrailing) {

            if let image = selectedImage {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: 120,
                        height: 120
                    )
                    .clipShape(Circle())
            } else {

                ProfilePlaceholderView()
            }

            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ) {

                ZStack {

                    Circle()
                        .fill(Color.theme)
                        .frame(
                            width: 36,
                            height: 36
                        )

                    Image(
                        systemName:
                            "camera.fill"
                    )
                    .foregroundColor(.white)
                }
            }
        }
        .padding(.top, 24)
    }
}

// MARK: Fields

extension ChildAddView {

    private var fieldBackground: some View {

        RoundedRectangle(
            cornerRadius: 12
        )
        .fill(Color.white)
        .overlay(
            RoundedRectangle(
                cornerRadius: 12
            )
            .stroke(
                Color.lightGrayStroke,
                lineWidth: 1
            )
        )
    }

    private var nameField: some View {

        TextField(
            "Full Name",
            text: $fullName
        )
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(fieldBackground)
    }

    private var classField: some View {

        Menu {

            ForEach(
                classList,
                id: \.self
            ) { item in

                Button(item) {

                    selectedClass = item
                }
            }

        } label: {

            HStack {

                Text(
                    selectedClass
                    ?? "Select Class"
                )

                Spacer()

                Image(
                    systemName:
                        "chevron.down"
                )
            }
            .foregroundColor(
                selectedClass == nil
                ? .gray
                : .black
            )
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(fieldBackground)
        }
    }

    private var sectionField: some View {

        Menu {

            ForEach(
                sectionList,
                id: \.self
            ) { item in

                Button(item) {

                    selectedSection = item
                }
            }

        } label: {

            HStack {

                Text(
                    selectedSection
                    ?? "Select Section"
                )

                Spacer()

                Image(
                    systemName:
                        "chevron.down"
                )
            }
            .foregroundColor(
                selectedSection == nil
                ? .gray
                : .black
            )
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(fieldBackground)
        }
    }

    private var dobField: some View {

        HStack {

            Text("Date of Birth")

            Spacer()

            DatePicker(
                "",
                selection:
                    $selectedDOB,
                in: ...Date(),
                displayedComponents:
                    .date
            )
            .labelsHidden()
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(fieldBackground)
    }

    private var schoolField: some View {

        Menu {

            ForEach(
                viewModel.schools
            ) { school in

                Button(
                    school.name
                ) {

                    selectedSchool =
                    school
                }
            }

        } label: {

            HStack {

                Text(
                    selectedSchool?.name
                    ?? "Select School"
                )

                Spacer()

                Image(
                    systemName:
                        "chevron.down"
                )
            }
            .foregroundColor(
                selectedSchool == nil
                ? .gray
                : .black
            )
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(fieldBackground)
        }
    }

    private var emergencyNameField: some View {

        TextField(
            "Emergency Contact Name",
            text:
                $emergencyName
        )
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(fieldBackground)
    }

    private var emergencyPhoneField: some View {

        TextField(
            "Emergency Contact Number",
            text:
                $emergencyPhone
        )
        .keyboardType(.numberPad)
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(fieldBackground)
    }
}

// MARK: Button

extension ChildAddView {

    private var saveButton: some View {

        Button {

            saveChild()

        } label: {

            Text(
                isEditMode
                ? "Update Child"
                : "Add Child"
            )
                .font(
                    .plexSansSemiBold(16)
                )
                .foregroundColor(.white)
                .frame(
                    maxWidth: .infinity
                )
                .frame(height: 50)
        }
        .background(
            isValid
            ? Color.theme
            : Color.disableColor
        )
        .cornerRadius(10)
        .disabled(!isValid)
    }

    private func saveChild() {

        guard let image =
            selectedImage
        else {
            return
        }
        
        let formatter = ISO8601DateFormatter()

        print(selectedDOB)
        
        let dob = formatter.string(from: selectedDOB)

        print(dob)
        
        if let child {

            viewModel.updateChild(
                child: child,
                fullName: fullName,
                dob: dob,
                studentClass: selectedClass ?? "",
                section: selectedSection ?? "",
                schoolId: selectedSchool?.id ?? "",
                emergencyName: emergencyName,
                emergencyPhone: emergencyPhone,
                image: selectedImage
            )

        } else {

            guard let image = selectedImage else {
                return
            }

            viewModel.addChild(
                fullName: fullName,
                dob: dob,
                studentClass: selectedClass ?? "",
                section: selectedSection ?? "",
                schoolId: selectedSchool?.id ?? "",
                emergencyName: emergencyName,
                emergencyPhone: emergencyPhone,
                image: image
            )
        }
    }
}

#Preview {

    NavigationStack {

        ChildAddView()
    }
}
