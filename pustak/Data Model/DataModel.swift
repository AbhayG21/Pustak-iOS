//
//  DataModel.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//


import Foundation

enum Role: String, CaseIterable{
    case libraryAdmin = "Library Admin"
    case librarian = "Librarian"
    case member = "Member"
}

enum Genre: String, CaseIterable{
    case fiction = "Fiction"
    case nonFiction = "Non-Fiction"
    case fantasy = "Fantasy"
    case scienceFiction = "Science Fiction"
    case mysteryAndThriller = "Mystery & Thriller"
    case romance = "Romance"
    case historical = "Historical"
}

struct Librarian: Identifiable{
    let id = UUID()
    let role: Role = .librarian
    let librarianName :String
    let assignedLibrary : String
    let officialEmail : String
    let personalEmail : String
    let mobNo : String
}

struct LibraryAdmin: Identifiable{
    let id = UUID()
    let role: Role = .libraryAdmin
    let email: String
    let name: String
    let mobNo: String
//    let libraries: [UUID]
//    let librarians: [UUID]
    let libraries: [String]
    let librarians: [String]
    
}

struct Member: Identifiable{
    let id = UUID()
    let role: Role = .member
    let email: String
    let name: String
    let mobNo: String
    let viewableLibraries: [UUID]
    let wishlistBooks: [UUID]
    let borrowedBooks: [UUID]
    let fine: [UUID]
}

struct Fine: Identifiable{
    let id = UUID()
    let userId: UUID
    let bookId: UUID
    let finePaid: Bool
    let amount: String
    let libraryId: UUID
}

struct Issues: Identifiable{
    let id = UUID()
    let bookId: UUID
    let startDate: Date
    let userId: UUID
    let approved: Bool
}

struct Library: Identifiable{
    let id = UUID()
    let librarianAssigned: UUID
    let admin: UUID
    let libraryName: String
    let libraryContact: String
    let libraryAddress: String
    let libraryEmail: String
    let books: [Books]
}

struct Books: Identifiable{
    let id = UUID()
    let ISBN: String
    let yearPublished: String
    let author: String
    let publisher: String
    let genre: Genre
    let nosPages: String
    let title: String
    let libraryId: UUID
    let qty: String
}
