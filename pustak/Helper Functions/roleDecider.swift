//
//  roleDecide.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import Foundation
import SwiftUI
func roleDecider(email: String, password: String) -> some View {
    let role = checkUserRole(email: email, password: password)
    return getDestinationView(for: role)
}

func checkUserRole(email: String, password: String) -> Role {
    // Replace this with your actual user validation logic
    if email == "admin@infy.com" && password == "admin123" {
        return .libraryAdmin
    } else if email == "librarian@infy.com" && password == "librarian123" {
        return .librarian
    } else if email == "member@infy.com" && password == "member123" {
        return .member
    } else {
        return .none
    }
}

@ViewBuilder
func getDestinationView(for role: Role) -> some View {
    switch role {
    case .libraryAdmin:
        AdminMainView()
    case .librarian:
        LibrarianMainView()
    case .member:
        EmptyView()
    case .none:
        Text("Invalid credentials")
            .foregroundColor(.red)
    }
}
