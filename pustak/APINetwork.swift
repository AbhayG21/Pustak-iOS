//
//  APINetwork.swift
//  pustak
//
//  Created by Abhay(IOS) on 31/05/24.
//

import Foundation

class UserSession: ObservableObject{
    @Published var isAuthenticated: Bool = false
    @Published var role: Role = .member
    
    init() {
        if let data = UserDefaults.standard.object(forKey: "userData") as? [String: Any],
           let storedRole = data["role"] as? String,
           let role = Role(rawValue: storedRole) {
            self.role = role
            isAuthenticated = true
        }
    }
}

class AuthNetworkManager: ObservableObject{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func loginUser(with data: Data) async throws{
        guard let url = URL(string: "http://localhost:7070/auth/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        
        if httpResponse.statusCode == 400 {
            DispatchQueue.main.async{
                self.isError = true
                self.errorMessage = "ERR 400: Bad Reqeust"
            }
        }else if httpResponse.statusCode == 401 {
            DispatchQueue.main.async{
                self.isError = true
                self.errorMessage = "ERR 401: Unauthorized"
            }
        }else if httpResponse.statusCode == 404 {
            DispatchQueue.main.async{
                self.isError = true
                self.errorMessage = "ERR 404: Not Found"
            }
        }
        
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let user = json["user"] as? [String: Any],
              let email = user["email"] as? String,
              let name = user["name"] as? String,
              let storedRole = user["role"] as? String,
              let mobileNo = user["mobNo"] as? String,
              let role = Role(rawValue: storedRole)
        else{ return }
        
        switch role{
        case .libraryAdmin:
            guard let librarians = user["librarians"] as? [String],
                  let libraries = user["libraries"] as? [String] else {return}
            
            let adm = LibraryAdmin(email: email, name: name, mobNo: mobileNo, libraries: libraries, librarians: librarians)
            break;
        case .librarian:
            break;
        case .member:
            break;
        }
    }
}
