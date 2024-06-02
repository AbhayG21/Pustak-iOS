//
//  AddLibrary.swift
//  pustak
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI

struct AddLibrary: View {
    @State private var libraryName:String = ""
    @State private var phone:String = ""
    @State private var email:String = ""
    @State private var address:String = ""
    //    @EnvironmentObject var adminManager:AdminManager
    //    @EnvironmentObject var userSession:UserSession
    var body: some View {
        NavigationStack{
            
            Form{
                Section("Library Name"){
                    TextField("Name",text:$libraryName)
                }
                Section("Contact Details"){
                    TextField("Email",text:$email)
                    TextField("Phone",text:$phone)
                }
                Section("Library Address"){
                    TextField("Address",text:$address)
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading)
                {
                    Button(action:{})
                    {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button(action:{})
                    {
                        Text("Add")
                    }
                }
            }
            
        }
    }
}

#Preview {
    AddLibrary()
}
