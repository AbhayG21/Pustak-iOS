//
//  AddBookView.swift
//  pustak
//
//  Created by Abhay(IOS) on 02/06/24.
//

import SwiftUI
import PhotosUI

struct AddBookView: View {
    @EnvironmentObject var userSession:UserSession
    @EnvironmentObject var librarianManager:LibrarianFetchBookManager
    @StateObject var addBookManager = LibrarianAddBookManager()
    @State private var title: String = ""
    @State private var ISBN: String = ""
    @State private var author: String = ""
    @State private var publisher:String = ""
    @State private var genre:Genre = .comedy
    @State private var nosPages:String = ""
    @State private var qty:String = ""
    @State private var bookDescription: String = ""
    @State private var yearPublished: String = ""
    let genres = Genre.allCases.map{$0.rawValue}
    
    @Environment(\.dismiss) var dismiss
    var libraryId:String
    var body: some View {
        NavigationView {
            List {
                Section {
//                    TextField("Book Name", text: $title)
                    InputField(text: $title, placeholder: "Title", cornerRadius: 10,height: 30)
                    InputField(text: $author, placeholder: "Author Name", cornerRadius: 10,height: 30)
                    InputField(text: $publisher, placeholder: "Publisher Name", cornerRadius: 10,height: 30)
                    InputField(text: $yearPublished, placeholder: "Year Published", cornerRadius: 10,height: 30)
                }
                Section {
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    InputField(text: $ISBN,placeholder: "ISBN", cornerRadius: 10,height: 30)
                    
                    InputField(text: $nosPages,placeholder: "Pages", cornerRadius: 10,height: 30)
                    
                    InputField(text: $qty,placeholder: "Quantity", cornerRadius: 10,height: 30)
                    
                }
                Section("Book Description") {
                    TextEditor(text: $bookDescription)
                        .frame(height: 150)
                }
                
            }
            .navigationBarTitle("New Book", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel", action: {
                // Handle cancel action
                dismiss()
            }), trailing: Button("Add", action: {
                Task{
                    do{
                        let libId = UUID(uuidString: libraryId)!
                        let book = Books(id: UUID(), ISBN: ISBN, title: title, yearPublished: yearPublished, author: author, publisher: publisher, genre: genre, nosPages: nosPages, libraryId: libId, qty: qty)
                        
                        try await addBookManager.addBook(with: book, of: librarianManager)
                        
                    }catch{}
                }
                dismiss()
            }))
        }
    }
}


//#Preview{
//    AddBookView()
//}
