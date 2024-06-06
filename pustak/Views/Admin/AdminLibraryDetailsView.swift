//
//  AdminLibraryDetailsView.swift
//  pustak
//
//  Created by Abhay(IOS) on 04/06/24.
//

import SwiftUI

struct AdminLibraryDetailsView: View {
    @EnvironmentObject var userSession:UserSession
    @EnvironmentObject var libraryDetailManager:AdminLibraryDetailManager
    @Environment (\.dismiss) var dismiss
    
    
    @State var isErrorShown: Bool = false
    var library:Library
    var body: some View {
        List {
            if(libraryDetailManager.isLoading)
            {
                ProgressView()
            }
            else{
                Section(header: Text("Library Details")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text(library.libraryName)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Contact")
                        Spacer()
                        Text(library.libraryContact)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Address")
                        Spacer()
                        Text(library.address)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(library.libraryEmail)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Books")
                        Spacer()
                        Text("\(library.books.count)")
                            .foregroundColor(.secondary)
                    }
                }
                
                if(library.librarianAssigned != nil)
                {
                    LibrarianDetailsCard(librarian: libraryDetailManager.librarian)
                }
                else{
                    Text("No librarian assigned")
                        .font(.largeTitle)
                        .foregroundStyle(Color.red)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Library Details")
        .onAppear(perform: {
            libraryDetailManager.isLoading = true
            Task{
                do{
                    try await libraryDetailManager.fetchLibraryDetails(id: library.id.uuidString)
                    DispatchQueue.main.async{
                        if(libraryDetailManager.isError)
                        {
                            print("huihui")
                            isErrorShown = true
                        }
                        else{
                            libraryDetailManager.isLoading = false
                        }
                    }
                }
            }
        })
        .alert("Error",isPresented: $isErrorShown){
            Button("OK", role: .destructive){
                isErrorShown = false
                libraryDetailManager.isError = false
                libraryDetailManager.errorMessage = ""
                dismiss()
                libraryDetailManager.isLoading = false
            }
        } message: {
            Text(libraryDetailManager.errorMessage)
        }
    }
}


//#Preview {
//    AdminLibraryDetailsView()
//}
