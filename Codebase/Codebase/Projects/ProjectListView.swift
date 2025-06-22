//
//  ProjectListView.swift
//  Codebase
//
//  Created by Bogdan on 20.06.2025.
//
import SwiftUI

struct ProjectListView: View {
    @StateObject private var viewModel = ProjectViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.projects) { project in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(project.title)
                            .font(.headline)
                        Text(project.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        if let imageURL = project.imageURL, let url = URL(string: imageURL) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        if let githubLink = project.githubLink {
                            Link("GitHub", destination: URL(string: githubLink)!)
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        Text("By: \(authViewModel.user?.username ?? "Unknown")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            NavigationLink("Edit", destination: EditProjectView(project: project))
                                .font(.caption)
                                .foregroundColor(.blue)
                            Button(action: {
                                Task {
                                    try await viewModel.deleteProject(id: project.id)
                                }
                            }) {
                                Text("Delete")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Projects")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign Out") {
                        authViewModel.signOut()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Add Project", destination: AddProjectView())
                }
            }
            .task {
                await viewModel.fetchProjects()
            }
        }
    }
}


#Preview {
    ProjectListView()
        .environmentObject(AuthViewModel())
}
