//
//  APINetwork.swift
//  pustak
//
//  Created by Abhay(IOS) on 31/05/24.


import Foundation
import SwiftUI

class UserSession: ObservableObject{
    @Published var isAuthenticated: Bool
    @Published var role: Role
    @Published var token: String
    @Published var uId: UUID
    
    init() {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String,
              let roleString = UserDefaults.standard.object(forKey: "role") as? String,
              let role = Role(rawValue: roleString),
              let uuidString = UserDefaults.standard.object(forKey: "id") as? String,
              let uId = UUID(uuidString: uuidString)
        else{
            self.isAuthenticated = false
            self.role = .member
            self.token = ""
            self.uId = UUID()
            return
        }
        
        self.role = role
        self.token = token
        self.uId = uId
        self.isAuthenticated = true
    }
}

class AuthNetworkManager: ObservableObject,ErrorHandling{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    init(){
        Task{
            do{
                guard let token = UserDefaults.standard.object(forKey: "token") as? String, token.count > 0 else {return}
                
                DispatchQueue.main.async{
                    self.isLoading = true
                }
                
                let _ = try await getSetData(type: "POST", endpoint: "verify",token: token)
                DispatchQueue.main.async{
                    self.isLoading = false
                }
            }catch{
                guard let error = error as? ErrorResponse else {return}
                //                self.isLoading = false
                self.errorHandler(error)
            }
        }
        
    }
    
    func loginUser(with data: Data) async throws{
        
        do{
            let data = try await getSetData(type: "POST", endpoint: "auth/login",body: data)
            guard let data = data else {throw ErrorResponse.noData}
            
            let decodedData = try JSONDecoder().decode(AuthResponse.self, from: data)
            
            DispatchQueue.main.async{
                UserDefaults.standard.set(decodedData.token, forKey: "token")
                UserDefaults.standard.set(decodedData.role.rawValue, forKey: "role")
                UserDefaults.standard.set(decodedData.id.uuidString, forKey: "id")
            }
            
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
        
    }
    
    //    func signUp(with data:Data)
}

class AdminManager: ObservableObject,ErrorHandling{
    @Published var libraries: [Library] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage: String = ""
    
    func fetchLibrary(with id:UUID) async throws{
        do{
            let data = try await getSetData(type: "GET", endpoint: "library/", token:fetchToken(),queryParams: ["id":id.uuidString])
            print(String(data: data!, encoding: .utf8)!)
            
            let decodedData = try JSONDecoder().decode(LibraryResponse.self, from: data!)
            DispatchQueue.main.async{
                self.libraries = decodedData.libraries
                self.isLoading = false
            }
        }catch{
            print(error)
            print("fnjsalka;snlanfl")
        }
    }
}

class AdminLibraryCreation:ObservableObject,ErrorHandling{
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage = ""
    func createLibrary(with library:Library, of instance:AdminManager) async throws
    {
        do{
            let body = try JSONEncoder().encode(library)
            let _ = try await getSetData(type: "POST", endpoint: "library/create",token: fetchToken(),body:body)
            
            DispatchQueue.main.async{
                instance.libraries.insert(library, at: 0)
                self.isLoading = false
            }
        }
        catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}


class AdminAssignLibrarian: ObservableObject,ErrorHandling{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func assignLibrarian(with librarian: Librarian, of instance: AdminManager) async throws {
        do{
            let body = try JSONEncoder().encode(librarian)
            let _ = try await getSetData(type:"POST", endpoint: "librarian/create", token: fetchToken(), body: body)
            
            DispatchQueue.main.async{
                let idxToUpdate = instance.libraries.firstIndex(where: {$0.id == librarian.assignedLibrary})!
                instance.libraries[idxToUpdate].librarianAssigned = librarian.id
            }
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}
class AdminUpdateLibrarianManager:ObservableObject,ErrorHandling{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func updateLibrarianDetails(with librarian:Librarian, of instance:AdminLibraryDetailManager) async throws{
        do{
            let body = try JSONEncoder().encode(librarian)
            let _ = try await getSetData(type: "POST", endpoint: "librarian/update",token: fetchToken(),body:body)
            
            DispatchQueue.main.async{
                instance.librarian = librarian
            }
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}

class AdminRevokeLibrarianManager:ObservableObject, ErrorHandling{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func revokeLibrarian(with id:UUID, of instance:AdminManager, of2 instance2:AdminLibraryDetailManager) async throws{
        do{
            let _ = try await getSetData(type: "PUT", endpoint: "librarian/remove/\(id.uuidString)",token: fetchToken())
            
            DispatchQueue.main.async{
                let idxToUpdate = instance.libraries.firstIndex(where: {$0.librarianAssigned == id})!
                instance.libraries[idxToUpdate].librarianAssigned = nil
                
                instance2.librarian = nil
            }
            
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}

class AdminDetailsManager:ObservableObject, ErrorHandling{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func getAdminDetails() async throws{
        do{
            
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}

class AdminUpdateLibraryManager:ObservableObject, ErrorHandling{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    func updateLibrary(with library:Library, of instance:AdminManager) async throws{
        do{
            let body = try JSONEncoder().encode(library)
            let _ = try await getSetData(type: "POST", endpoint: "library/update",token: fetchToken(),body: body)
            DispatchQueue.main.async{
                let idxToUpdate = instance.libraries.firstIndex(where: {$0.id == library.id})!
                instance.libraries[idxToUpdate] = library
                self.isLoading = false
            }
            
        }catch{
            print(error)
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}

class AdminLibraryDetailManager: ObservableObject, ErrorHandling{
    @Published var librarian: Librarian?
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func fetchLibraryDetails(id: String) async throws {
        do{
            let data = try await getSetData(type:"GET", endpoint: "librarian/all/\(id)", token: fetchToken())
            print("DATA")
            print(String(data: data!, encoding: .utf8)!)
            let decodedData = try JSONDecoder().decode(LibraryDetailResponse.self, from: data!)
            print("HUIHUI")
            print( decodedData)
            DispatchQueue.main.async{
                self.librarian = decodedData.librarian
                self.isLoading = false
            }
        }catch{
            print(error)
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
        
    }
}



class GetLibraryManager:ObservableObject, ErrorHandling{
    @Published var libraryId:String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func getLibraryId(with id:UUID) async throws{
        do{
            let data = try await getSetData(type: "GET", endpoint: "library/\(id)",token: fetchToken())
            let decodedData = try JSONDecoder().decode(LibraryIdResponse.self, from: data!)
            DispatchQueue.main.async{
                self.libraryId = decodedData.library.id.uuidString
                self.isLoading = false
            }
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}

class LibrarianFetchBookManager:ObservableObject, ErrorHandling{
    @Published var books: [Books] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func fetchBooks(with id:UUID) async throws{
        do{
            let data = try await getSetData(type: "GET", endpoint: "book/all/\(id)", token: fetchToken())
            let decodedData = try JSONDecoder().decode(BooksResponse.self, from: data!)
            DispatchQueue.main.async{
                self.books = decodedData.books
                self.isLoading = false
            }
        }catch{
            guard let error  = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
    
}

class LibrarianAddBookManager:ObservableObject, ErrorHandling{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func addBook(with book:Books, of instance:LibrarianFetchBookManager) async throws{
        do{
            let body = try JSONEncoder().encode(book)
            let _ = try await getSetData(type: "POST", endpoint: "book/create",token: fetchToken(),body:body)
            DispatchQueue.main.async{
                instance.books.insert(book,at:0)
                self.isLoading = false
            }
            
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}

class LibrarianUpdateBookManager:ObservableObject, ErrorHandling{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func updateBook(with book:Books, of instance:LibrarianFetchBookManager) async throws{
        do{
            let body = try JSONEncoder().encode(book)
            let _ = try await getSetData(type: "POST", endpoint: "book/update",token: fetchToken(),body: body)
            DispatchQueue.main.async{
                let idxToUpdate = instance.books.firstIndex(where: {$0.id == book.id})!
                instance.books[idxToUpdate] = book
                self.isLoading = false
            }
            
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}
class LibrarianDeleteBookManager:ObservableObject,ErrorHandling{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func deleteBook(with book:Books, of instance:LibrarianFetchBookManager) async throws{
        do{
            let body = try JSONEncoder().encode(book)
            let _ =  try await getSetData(type: "POST", endpoint: "book/remove",token: fetchToken(),body:body)
            DispatchQueue.main.async{
                let idxToUpdate = instance.books.firstIndex(where: {$0.id == book.id})!
                instance.books.remove(at: idxToUpdate)
                self.isLoading = false
            }
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
    }
}
