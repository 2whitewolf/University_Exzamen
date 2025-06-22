//
//  EditProjectView.swift
//  Codebase
//
//  Created by Bogdan on 20.06.2025.
//
import SwiftUI

struct EditProjectView: View {
    @StateObject private var viewModel = ProjectViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var title: String
    @State private var description: String
    @State private var githubLink: String
    @State private var image: UIImage?
    @State private var showImagePicker = false
    @Environment(\.dismiss) private var dismiss
    let project: Project
    
    init(project: Project) {
        self.project = project
        _title = State(initialValue: project.title)
        _description = State(initialValue: project.description)
        _githubLink = State(initialValue: project.githubLink ?? "")
    }
    
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
                    } else if let imageURL = project.imageURL, let url = URL(string: imageURL) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                
                if let username = authViewModel.user?.username {
                    Section(header: Text("Author")) {
                        Text(username)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Edit Project")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            try await viewModel.updateProject(
                                id: project.id,
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
