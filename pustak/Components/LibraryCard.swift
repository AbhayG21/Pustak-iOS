//
//  LibraryCard.swift
//  pustak
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI

struct LibraryCard: View {
    var library:Library
    @EnvironmentObject var libraryDetailManager:AdminLibraryDetailManager

    
    func librarianNotAssigned() -> Bool{
            return library.librarianAssigned == nil
        }
    var body: some View {
        //            HStack {
        //                VStack(alignment:.leading){
        //                    Text(library.libraryName)
        //                        .font(.headline)
        //                        .foregroundColor(.primary)
        //
        //                    if(library.librarianAssigned == nil)
        //                    {
        //                        Text("No librarian assigned")
        //                            .font(.caption)
        //                            .foregroundStyle(Color.red)
        //                    }
        //                    else{
        //                        Text("\(library.address)")
        //                            .foregroundStyle(Color.black)
        //                    }
        //                }
        //                Spacer()
        //                if library.librarianAssigned == nil {
        //                    AssignButton(library:library)
        //                }
        //                else
        //                {
        //                    Image(systemName: "person.crop.circle")
        //                        .resizable()
        //                        .frame(width: 50,height: 50)
        //                        .foregroundStyle(Color.black)
        //                }
        //            }
        //            .padding()
        //            .background(Color(UIColor.systemBackground))
        //            .cornerRadius(12)
        //            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        //            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        
        ZStack{
            NavigationLink(destination:AdminLibraryDetailsView(library: library).environmentObject(libraryDetailManager)){
                HStack {
                    VStack(alignment: .leading) {
                        Text(library.libraryName)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        if library.librarianAssigned == nil {
                            Text("No librarian assigned")
                                .font(.caption)
                                .foregroundColor(.red)
                        } else {
                            Text(library.address)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                    
                     if(!librarianNotAssigned()) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.primary)
                    }
                    
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                .frame(height: 100)
                .frame(maxHeight: 100)
            }
            .disabled(librarianNotAssigned())
            if(librarianNotAssigned())
            {
                HStack{
                    Spacer()
                AssignButton(library: library)
                }.frame(maxWidth: .infinity)
            }
        }
        
    }
}
//#Preview {
//    AdminLibrariesView()
//}

//            if(assignedLibrarian == nil)
//            {
//                VStack(alignment: .leading){
//                    Text(libraryName)
//                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                    Text("Librarian assigned:  \(assignedLibrarian!)")
//                        .font(.caption)
//                }
//
//            }

//VStack(alignment: .leading){
//                Text(libraryName)
//                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
//                Text("Librarian assigned:  \(assignedLibrarian!)")
//                    .font(.caption)
//            }
