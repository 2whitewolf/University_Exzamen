//
//  AuthResponse.swift
//  Codebase
//
//  Created by Bogdan on 20.06.2025.
//

import Foundation 
struct AuthResponse: Codable {
    let token: String
    let user: User
}
