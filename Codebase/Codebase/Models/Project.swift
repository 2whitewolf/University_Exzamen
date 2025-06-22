//
//  Project.swift
//  Codebase
//
//  Created by Bogdan on 20.06.2025.
//
import Foundation

struct Project: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let imageURL: String?
    let githubLink: String?
    let author: String
    let createdAt: Date
}
