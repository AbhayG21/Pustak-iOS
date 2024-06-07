//
//  Responce.swift
//  pustak
//
//  Created by Abhay(IOS) on 02/06/24.
//

import Foundation

struct AuthResponse:Codable{
    let id:UUID
    let message: String
    let token: String
    let role: Role
    let user: any User
    
    enum CodingKeys: String, CodingKey{
        case id
        case message
        case token
        case role
        case user
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self,forKey: .id)
        self.message = try container.decode(String.self, forKey: .message)
        self.token = try container.decode(String.self, forKey: .token)
        self.role = try container.decode(Role.self, forKey: .role)
        
        
        
        switch self.role {
        case .libraryAdmin:
            self.user = try container.decode(LibraryAdmin.self, forKey: .user)
        case .librarian:
            self.user = try container.decode(Librarian.self, forKey: .user)
        case .member:
            self.user = try container.decode(Member.self, forKey: .user)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(token, forKey: .token)
        try container.encode(role, forKey: .role)
        
        switch self.role {
        case .libraryAdmin:
            try container.encode(user as! LibraryAdmin, forKey: .user)
        case .librarian:
            try container.encode(user as! Librarian, forKey: .user)
        case .member:
            try container.encode(user as! Member, forKey: .user)
        }
        
    }
}
struct LibraryResponse: Codable{
    var message: String
    var libraries: [Library]
    var librarians: [Librarian]
}
struct LibraryDetailResponse:Codable{
    var message: String
    var librarian: Librarian
}
struct LibraryIdResponse:Codable{
    var message:String
    var library:Library
}

struct BooksResponse:Codable
{
    var message:String
    var books:[Books]
}
