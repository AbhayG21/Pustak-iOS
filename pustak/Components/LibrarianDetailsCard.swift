//
//  LibrarianDetailsCard.swift
//  pustak
//
//  Created by Abhay(IOS) on 05/06/24.
//

import SwiftUI

struct LibrarianDetailsCard: View {
    @State var isEditShown = false
    var librarian:Librarian?
    var body: some View {
        if let librarian = librarian{
            Section("Librarian details")
            {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(librarian.name)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Email")
                    Spacer()
                    Text(librarian.email)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Contact")
                    Spacer()
                    Text(librarian.phone)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Official Email")
                    Spacer()
                    Text(librarian.personalEmail)
                        .foregroundColor(.secondary)
                }
                Button(action:{
                    isEditShown = true
                }){
                    Text("Edit library details")
                }
            }
            .sheet(isPresented:$isEditShown)
            {
                EditLibrarianDetailsView(librarian:librarian)
            }
        }
    }
}

#Preview {
    LibrarianDetailsCard(librarian: Librarian(id: UUID(), role: .librarian, name: "Manav", email: "manav@gmail.com", admin: UUID(), assignedLibrary: UUID(), phone: "9876543456789", personalEmail: "librarian@infosys.com"))
}
