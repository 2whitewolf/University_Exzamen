//
//  ProjectViewModel.swift
//  Codebase
//
//  Created by Bogdan on 20.06.2025.
//
import SwiftUI

class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = [
        Project(
                        id: "project1",
                        title: "Task Manager App",
                        description: "A mobile app for managing daily tasks with reminders and categories.",
                        imageURL: "https://example.com/images/task-manager.jpg",
                        githubLink: "https://github.com/username/task-manager",
                        author: "john_doe",
                        createdAt: Date(timeIntervalSince1970: 1717228800) // 2025-06-01
                    ),
                    Project(
                        id: "project2",
                        title: "Weather Dashboard",
                        description: "A web app displaying real-time weather data using a public API.",
                        imageURL: nil,
                        githubLink: "https://github.com/username/weather-dashboard",
                        author: "john_doe",
                        createdAt: Date(timeIntervalSince1970: 1717597800) // 2025-06-05
                    ),
                    Project(
                        id: "project3",
                        title: "Photo Gallery",
                        description: "A SwiftUI-based photo gallery with cloud storage integration.",
                        imageURL: "https://example.com/images/photo-gallery.jpg",
                        githubLink: nil,
                        author: "john_doe",
                        createdAt: Date(timeIntervalSince1970: 1718007300) // 2025-06-10
                    )
    ]
    
    func fetchProjects() async {
        do {
            let projects = try await APIService.shared.fetchProjects()
            await MainActor.run {
                self.projects = projects
            }
        } catch {
            print("Error fetching projects: \(error)")
        }
    }
    
    func addProject(title: String, description: String, githubLink: String?, image: UIImage?) async throws {
        let project = try await APIService.shared.addProject(title: title, description: description, githubLink: githubLink, image: image)
        await MainActor.run {
            self.projects.append(project)
        }
    }
    
    func updateProject(id: String, title: String, description: String, githubLink: String?, image: UIImage?) async throws {
        let updatedProject = try await APIService.shared.updateProject(id: id, title: title, description: description, githubLink: githubLink, image: image)
        await MainActor.run {
            if let index = self.projects.firstIndex(where: { $0.id == id }) {
                self.projects[index] = updatedProject
            }
        }
    }
    
    func deleteProject(id: String) async throws {
        try await APIService.shared.deleteProject(id: id)
        await MainActor.run {
            self.projects.removeAll { $0.id == id }
        }
    }
}
