//
//  APINetwork.swift
//  pustak
//
//  Created by Abhay(IOS) on 31/05/24.


import Foundation

class UserSession: ObservableObject{
    @Published var isAuthenticated: Bool = false
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
        //        Task{
        //            do{
        //                guard let token = UserDefaults.standard.object(forKey: "token") as? String else { return }
        //                guard let url = URL(string: "\(apiURL)verify") else { return }
        //                DispatchQueue.main.async{
        //                    self.isLoading = true
        //                }
        //                var request = URLRequest(url: url)
        //                request.httpMethod = "POST"
        //                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //
        //                let (_, response) = try await URLSession.shared.data(for: request)
        //
        //                guard let httpResponse = response as? HTTPURLResponse else {
        //                    return
        //                }
        //
        //                if httpResponse.statusCode == 400 {
        //                    DispatchQueue.main.async{
        //                        print("400")
        //                        self.isError = true
        //                        self.errorMessage = "ERR 400: Bad Reqeust"
        //                    }
        //                }else if httpResponse.statusCode == 401 {
        //                    DispatchQueue.main.async{
        //                        print("401")
        //                        self.isError = true
        //                        self.errorMessage = "ERR 401: Unauthorized"
        //                    }
        //                }
        //                DispatchQueue.main.async{
        //                    self.isLoading = false
        //                }
        //
        //            }catch{
        //                print("\(error)")
        //            }
        
        Task{
            do{
                guard let token = UserDefaults.standard.object(forKey: "token") as? String else {return}
                
                DispatchQueue.main.async{
//                    self.isLoading = true
                }
                
                let _ = try await getSetData(type: "POST", endpoint: "verify",token: token)
                DispatchQueue.main.async{
                    self.isLoading = false
                }
            }catch{
                guard let error = error as? ErrorResponse else {return}
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
        //        print(data)
        //        guard let url = URL(string: "\(apiURL)auth/login") else { return }
        //        var request = URLRequest(url: url)
        //        request.httpMethod = "POST"
        //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.httpBody = data
        //        let (data, response) = try await URLSession.shared.data(for: request)
        //        //        print(response)
        //        guard let httpResponse = response as? HTTPURLResponse else {
        //            return
        //        }
        //
        //        if httpResponse.statusCode == 400 {
        //            DispatchQueue.main.async{
        //                print("400")
        //                self.isError = true
        //                self.errorMessage = "ERR 400: Bad Reqeust"
        //            }
        //        }else if httpResponse.statusCode == 401 {
        //            DispatchQueue.main.async{
        //                print("401")
        //                self.isError = true
        //                self.errorMessage = "ERR 401: Unauthorized"
        //            }
        //        }else if httpResponse.statusCode == 404 {
        //            DispatchQueue.main.async{
        //                print("404")
        //                self.isError = true
        //                self.errorMessage = "ERR 404: Not Found"
        //            }
        //        }
        //        else{
        //            print(httpResponse.statusCode)
        //        }
        //
        //        do{
        //            let decodedData = try JSONDecoder().decode(AuthResponse.self, from: data)
        //            DispatchQueue.main.async{
        //                UserDefaults.standard.set(decodedData.token, forKey: "token")
        //                UserDefaults.standard.set(decodedData.role.rawValue, forKey: "role")
        //                UserDefaults.standard.set(decodedData.id.uuidString,forKey: "id")
        //            }
        //        }catch{
        //            print("\(error)")
        //        }
    }
}

class AdminManager: ObservableObject,ErrorHandling{
    @Published var libraries: [Library] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage: String = ""
    
    //    func createLibrary(with library:Library) async throws
    //    {
    //        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {return}
    //        guard let url = URL(string:"\(apiURL)library/create") else {return}
    //        var request = URLRequest(url:url)
    //        request.httpMethod = "POST"
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.setValue("Bearer \(token)", forHTTPHeaderField: "authorization")
    //        let jsonData = try JSONEncoder().encode(library)
    //        request.httpBody = jsonData
    //        let (_, response) = try await URLSession.shared.data(for:request)
    //        print(response)
    //        DispatchQueue.main.async{
    //            self.libraries.insert(library, at: 0)
    //            self.isLoading = false
    //        }
    //
    //    }
    
    //    func fetchLibrary() async throws{
    //        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {return}
    //        guard let url = URL(string:"\(apiURL)library/") else {return}
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "GET"
    //        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    //        //        print(request)
    //        let (data, _) = try await URLSession.shared.data(for:request)
    //        let libraries = try JSONDecoder().decode([Library].self, from: data)
    //        //        print(libraries)
    //        DispatchQueue.main.async{
    //            self.libraries = libraries
    //            self.isLoading = false
    //        }
    //
    //    }
    
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
    @Published var library: Library?
    @Published var librarian: Librarian?
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func fetchLibraryDetails(id: String) async throws {
        do{
            let data = try await getSetData(type:"GET", endpoint: "library/\(id)", token: fetchToken())
            let decodedData = try JSONDecoder().decode(LibraryDetailResponse.self, from: data!)
            
            DispatchQueue.main.async{
                self.librarian = decodedData.librarian
                self.library = decodedData.library
                self.isLoading = false
            }
        }catch{
            guard let error = error as? ErrorResponse else {return}
            self.errorHandler(error)
        }
        
    }
}
//    func assignLibrarian(with librarian:Librarian, auth token:String) async throws{
//        guard let url = URL(string: "\(apiURL)librarian/create") else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-type")
//        
//        let encodedData = try JSONEncoder().encode(librarian)
//        request.httpBody = encodedData
//        
//        let (_, response) = try await URLSession.shared.data(for: request)
//        
//        guard let response = response as? HTTPURLResponse else {return}
//        
//        DispatchQueue.main.async{ [self] in
//            switch response.statusCode{
//            case 409:
//                self.isError = true
//                self.errorMessage = "Duplicate e-mails, please change the e-mail and request again"
//            case 201:
//                let idxToUpdate = self.libraries.firstIndex(where: {$0.id == librarian.assignedLibrary})!
//                self.libraries[idxToUpdate].librarianAssigned = librarian.id
//            default:
//                break;
//            }
//        }
//    }



