//
//  AddProjectView.swift
//  Codebase
//
//  Created by Bogdan on 20.06.2025.
//
import SwiftUI

struct AddProjectView: View {
    @StateObject private var viewModel = ProjectViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var githubLink = ""
    @State private var image: UIImage?
    @State private var showImagePicker = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Project Details")) {
                    TextField("Title", text: $title)
                    TextEditor(text: $description)
                        .frame(height: 100)
                    TextField("GitHub Link (optional)", text: $githubLink)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Image")) {
                    Button(action: { showImagePicker = true }) {
                        Text(image == nil ? "Select Image" : "Change Image")
                    }
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    }
                }
                
                if let username = authViewModel.user?.username {
                    Section(header: Text("Author")) {
                        Text(username)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Add Project")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            try await viewModel.addProject(
                                title: title,
                                description: description,
                                githubLink: githubLink.isEmpty ? nil : githubLink,
                                image: image
                            )
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty || description.isEmpty)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
            }
        }
    }
}
