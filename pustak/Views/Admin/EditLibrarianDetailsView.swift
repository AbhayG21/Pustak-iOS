//
//  EditLibrarianDetailsView.swift
//  pustak
//
//  Created by Abhay(IOS) on 07/06/24.
//

import SwiftUI

struct EditLibrarianDetailsView: View {
    var librarian:Librarian
    @EnvironmentObject var userSession:UserSession
    @EnvironmentObject var adminDetailManager:AdminLibraryDetailManager
    @Environment (\.dismiss) var dismiss
    
    @StateObject var adminUpdateLibrarianDetailsManager = AdminUpdateLibrarianManager()
    @State private var name:String = ""
    @State private var phone:String = ""
    @State private var personalEmail:String = ""
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Librarian name")){
                    InputField(text: $name, placeholder: "Library name", cornerRadius: 10,height: 30)
                }
                Section("Librarian Contact"){
                    InputField(text: $phone, placeholder: "Library name", cornerRadius: 10,height: 30)
                }
                Section("Personal Email"){
                    InputField(text: $personalEmail, placeholder: "Library name", cornerRadius: 10,height: 30)
                }
            }
            .navigationTitle("Edit Librarian")
            .toolbar{
                ToolbarItem(placement:.topBarLeading){
                    Button(action:{
                        dismiss()
                    }){
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement:.topBarTrailing){
                    Button(action:{
                        let librarian = Librarian(id: librarian.id, role: .librarian, name: name, email: librarian.email, admin: userSession.uId, assignedLibrary: librarian.assignedLibrary, phone: phone, personalEmail: personalEmail, timestamp: librarian.timestamp)
                        
                        Task{
                            do{
                                try await adminUpdateLibrarianDetailsManager.updateLibrarianDetails(with: librarian, of: adminDetailManager)
                            }catch{}
                        }
                        dismiss()
                    }){
                        Text("Save")
                    }
                }
            }
            .onAppear(perform: {
                name = librarian.name
                phone = librarian.phone
                personalEmail = librarian.personalEmail
            })
        }
    }
}
//#Preview {
//    EditLibrarianDetailsView()
//}
