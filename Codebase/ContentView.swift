//
//  ContentView.swift
//  Codebase
//
//  Created by Bogdan on 20.06.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
       
       var body: some View {
           Group {
               if authViewModel.user == nil {
                   AuthView()
               } else {
                   ProjectListView()
                       .environmentObject(authViewModel)
               }
           }
       }
}

#Preview {
    ContentView()
}
