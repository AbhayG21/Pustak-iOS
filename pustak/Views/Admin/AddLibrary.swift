//
//  AddLibrary.swift
//  pustak
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI

struct AddLibrary: View {
    @Environment(\.dismiss) var dismiss
    @State private var libraryName:String = ""
    @State private var phone:String = ""
    @State private var email:String = ""
    @State private var address:String = ""
    @EnvironmentObject var adminManager:AdminManager
    @EnvironmentObject var userSession:UserSession
    @StateObject var libraryCreate = AdminLibraryCreation()
    
    private func isAddDisabled()->Bool{
        return libraryName.isEmpty || phone.isEmpty || email.isEmpty || address.isEmpty || !isValidEmail(email)
    }
    var body: some View {
        NavigationStack{
            
            Form{
                Section("Library Name"){
                    TextField("Name",text:$libraryName)
                        .autocorrectionDisabled()
                        
                }
                Section("Library Contact Details"){
                    TextField("Email",text:$email)
                        .keyboardType(.emailAddress)
                    TextField("Phone",text:$phone)
                        .keyboardType(.numberPad)
                }
                Section("Library Address"){
                    TextField("Address",text:$address)
                }
            }
            .toolbar{
//                ToolbarItem(placement: .topBarLeading)
//                {
//                    Button(action:{
//                    })
//                    {
//                        Text("Cancel")
//                    }
//                }
                
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button(action:{
                        guard let id = UserDefaults.standard.object(forKey: "id") as? String else {return}
                        
                        
                        let admId = UUID(uuidString: id)!
                        
                        let library = Library(adminID:admId, name: libraryName, contact: phone, address: address, email: email)
                        Task{
                            do{
                                try await libraryCreate.createLibrary(with: library, of: adminManager)
                            }catch{}
                        }
                        dismiss()
                    })
                    {
                        Text("Add")
                    }
                    .disabled(isAddDisabled())
                }
            }
            
        }
    }
}

//#Preview {
//    AddLibrary()
//}
