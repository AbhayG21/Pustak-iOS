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


class AdminLibraryDetailManager: ObservableObject, ErrorHandling{
    @Published var librarian: Librarian?
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func fetchLibraryDetails(id: String) async throws {
        do{
            let data = try await getSetData(type:"GET", endpoint: "librarian/\(id)", token: fetchToken())
            let decodedData = try JSONDecoder().decode(LibraryDetailResponse.self, from: data!)
            
            DispatchQueue.main.async{
                self.librarian = decodedData.librarian
                self.isLoading = false
            }
        }catch{
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
    
    func getLibraryId( ) async throws{
        
    }
}

class LibrarianFetchBookManager:ObservableObject, ErrorHandling{
    @Published var Book: [Books] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func fetchBooks(with id:UUID) async throws{
        do{
            let data = try await getSetData(type: "GET", endpoint: "book/", token: fetchToken())
        }
    }
    
}
