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


enum Genre: String, CaseIterable,Codable{
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
    var admin: UUID
    let assignedLibrary : UUID
    let phone : String
    let personalEmail: String
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

struct Library: Identifiable, Codable{
    let id:UUID
    var librarianAssigned: UUID?
    let libraryAdmin: UUID
    let libraryName: String
    let libraryContact: String
    let address: String
    let libraryEmail: String
    let books: [Books]
    
    enum CodingKeys: String, CodingKey {
            case id
            case librarianAssigned
            case libraryAdmin
            case libraryName
            case libraryContact
            case address
            case libraryEmail = "email"
            case books
        }
    
    init(adminID: UUID, name: String, contact: String, address: String, email: String, libraryId id: UUID = UUID(), librarianAssigned libAss: UUID? = nil){
            self.id = id
            if let libAss = libAss {
                self.librarianAssigned = libAss
            }else{
                librarianAssigned = nil
            }
            libraryAdmin = adminID
            libraryName = name
            libraryContact = contact
            self.address = address
            books =  []
            libraryEmail = email
        }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            librarianAssigned = try container.decodeIfPresent(UUID.self, forKey: .librarianAssigned)
        libraryAdmin = try container.decode(UUID.self, forKey: .libraryAdmin)
            libraryName = try container.decode(String.self, forKey: .libraryName)
            libraryContact = try container.decode(String.self, forKey: .libraryContact)
            address = try container.decode(String.self, forKey: .address)
            libraryEmail = try container.decode(String.self, forKey: .libraryEmail)
            books = try container.decode([Books].self, forKey: .books)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encodeIfPresent(librarianAssigned, forKey: .librarianAssigned)
            try container.encode(libraryAdmin, forKey: .libraryAdmin)
            try container.encode(libraryName, forKey: .libraryName)
            try container.encode(libraryContact, forKey: .libraryContact)
            try container.encode(address, forKey: .address)
            try container.encode(libraryEmail, forKey: .libraryEmail)
            try container.encode(books, forKey: .books)
        }
}

struct Books: Identifiable,Codable{
    let id:UUID
    let ISBN: String
    let title: String
    let yearPublished: String
    let author: String
    let publisher: String
    let genre: Genre
    let nosPages: String
    let libraryId: UUID
    let qty: String
}
