//
//  DataModel.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//


import Foundation


protocol User: Codable, Identifiable{
    var id: UUID { get }
    var name: String { get }
    var email: String { get }
    var role: Role { get}
    var phone: String { get }
}



enum Role: String, CaseIterable,Codable{
    case libraryAdmin = "Library Admin"
    case librarian = "Librarian"
    case member = "Member"
}


enum Genre: String, CaseIterable{
    case fiction = "Fiction"
    case nonFiction = "Non-Fiction"
    case comedy = "Comedy"
    
    case fantasy = "Fantasy"
    case scienceFiction = "Science Fiction"
    case mysteryAndThriller = "Mystery & Thriller"
    case romance = "Romance"
    case historical = "Historical"
}

struct Librarian: Identifiable,Codable,User{
    let id:UUID
    let role: Role
    var name: String
    var email: String
    let assignedLibrary : String
    let phone : String
}

struct LibraryAdmin: Identifiable,Codable,User{
    let id: UUID
    let role:Role
    let name: String
    let email: String
    let phone: String
    let libraries: [UUID]
    let librarians: [UUID]
    
}

struct Member: Identifiable,Codable,User{
    let id:UUID
    let role: Role
    let name: String
    let email: String
    let phone: String
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
    let libraryAdmin: UUID
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
