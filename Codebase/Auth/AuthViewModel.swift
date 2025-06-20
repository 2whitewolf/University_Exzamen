//
//  AuthViewModel.swift
//  Codebase
//
//  Created by Bogdan on 20.06.2025.
//
import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var user: User? = User(id: UUID().uuidString, username: "Bogdan", email: "bogdansh.02@gmail.com")
    @Published var errorMessage: String?
    
    func signUp(email: String, password: String, username: String) async {
        do {
            let response = try await APIService.shared.register(email: email, password: password, username: username)
            self.user = response.user
            APIService.shared.setAuthToken(response.token)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            let response = try await APIService.shared.login(email: email, password: password)
            self.user = response.user
            APIService.shared.setAuthToken(response.token)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func signOut() {
        user = nil
        APIService.shared.setAuthToken(nil)
    }
}
