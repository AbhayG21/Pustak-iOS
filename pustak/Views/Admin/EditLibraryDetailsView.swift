//
//  EditLibraryDetailsView.swift
//  pustak
//
//  Created by Abhay(IOS) on 07/06/24.
//

import SwiftUI

struct EditLibraryDetailsView: View {
    var library:Library
    @EnvironmentObject var userSession:UserSession
    @EnvironmentObject var adminManager:AdminManager
    @Environment (\.dismiss) var dismiss
    @StateObject var adminUpdateLibraryManager = AdminUpdateLibraryManager()
    @State private var libraryName:String = ""
    @State private var phone:String = ""
    @State private var email:String = ""
    @State private var address:String = ""
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Library Name")) {
                    
                    InputField(text: $libraryName, placeholder: "Library name", cornerRadius: 10,height: 30)
                }
                Section(header:Text("Library Contact")){
                    InputField(text: $phone, placeholder: "Library Contact", cornerRadius: 10,height: 30)
                }
                Section(header:Text("Library Email")){
                    InputField(text: $email, placeholder: "Library Email", cornerRadius: 10,height: 30)
                }
                Section(header:Text("Library Address")){
                    InputField(text: $address, placeholder: "Library Address", cornerRadius: 10,height: 30)
                }
            }
            .navigationTitle("Edit Library")
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
                        let library = Library(adminID: userSession.uId, name: libraryName, contact:phone, address:address, email: email, libraryId: library.id, librarianAssigned: library.librarianAssigned)
                        Task{
                            do{
                                try await adminUpdateLibraryManager.updateLibrary(with: library, of: adminManager)
                            }catch{}
                        }
                        dismiss()
                    }){
                        Text("Save")
                    }
                }
            }
            .onAppear(perform: {
                libraryName = library.libraryName
                phone = library.libraryContact
                email = library.libraryEmail
                address = library.address
            })
        }
        
        
    }
}


//#Preview {
//    EditLibraryDetailsView()
//}
