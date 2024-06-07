//
//  AdminLibrariansView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct AssignLibrarian: View {
    @Environment(\.dismiss) var dismiss
    @State var name:String = ""
    @State var phone:String = ""
    @State var personalEmail:String = ""
    @State var officialEmail:String = ""
    
    @EnvironmentObject var adminManager:AdminManager
    @EnvironmentObject var userSession:UserSession
    @StateObject var adminAssignLibrarian = AdminAssignLibrarian()
    
    @State private var errorPresented: Bool = false
    var library:Library
    func isDisabled() -> Bool {
        return name.isEmpty || phone.isEmpty || !isValidEmail(personalEmail) || !isValidEmail(officialEmail) || !isValidNumber(phone)
        }
    var body: some View {
        NavigationStack{
            Form{
                Section("Personal Details")
                {
                    TextField(text: $name, label: {
                        Text("Full Name")
                    })
                    
                    TextField(text:$phone,label:{
                        Text("Phone Number")
                    })
                    TextField(text:$personalEmail,label: {
                        Text("Librarian Personal Email")
                    }).keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Section("Official Details")
                        {
                    TextField(text:$officialEmail,label:{
                        Text("Official Email")
                    })
                    .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button(action:{
                        dismiss()
                    }){Text("Cancel")}
                }
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button(action:{
                        let librarian = Librarian(id: UUID(), role: .librarian, name: name, email: officialEmail, admin: userSession.uId, assignedLibrary: library.id, phone: phone, personalEmail: personalEmail, timestamp: Date())
                        
                        Task{
                            do{
                                try await adminAssignLibrarian.assignLibrarian(with: librarian, of: adminManager)
                                
                                DispatchQueue.main.async{
                                    if(adminAssignLibrarian.isError)
                                    {
                                        errorPresented = true
                                    }
                                }
                            }
                            dismiss()
                            
                        }
                        
                    }){
                        Text("Add")
                    }
                    .disabled(isDisabled())
                }
                
            }
        }
    }
}

//#Preview {
//    AssignLibrarian()
//}
