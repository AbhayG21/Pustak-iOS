//
//  LibraryCard.swift
//  pustak
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI

struct LibraryCard: View {
    var libraryName:String
    var assignedLibrarian:String
    var body: some View {
        HStack(spacing:12){
            Image(systemName: "book.circle")
                .resizable()
                .frame(width: 50,height: 50)
                .padding(.horizontal,12)
            
            VStack(alignment: .leading){
//                Text((library?.libraryName)!)
                Text(libraryName)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Librarian assigned:  \(assignedLibrarian)")
                    .font(.caption)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal,12)
        
    }
}

#Preview {
    AdminLibrariesView()
}
