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
    
    init() {
//        UserDefaults.standard.set(nil, forKey: "token")
        guard let token = UserDefaults.standard.object(forKey: "token") as? String,
              let roleString = UserDefaults.standard.object(forKey: "role") as? String,
              let role = Role(rawValue: roleString)
        else{
            self.isAuthenticated = false
            self.role = .member
            self.token = ""
            return
        }
        
        self.role = role
        self.token = token
        self.isAuthenticated = true
    }
}

class AuthNetworkManager: ObservableObject{
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    init(){
        Task{
            do{
                guard let token = UserDefaults.standard.object(forKey: "token") as? String else { return }
                guard let url = URL(string: "\(apiURL)verify") else { return }
                DispatchQueue.main.async{
                    self.isLoading = true
                }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                let (_, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                
                if httpResponse.statusCode == 400 {
                    DispatchQueue.main.async{
                        print("400")
                        self.isError = true
                        self.errorMessage = "ERR 400: Bad Reqeust"
                    }
                }else if httpResponse.statusCode == 401 {
                    DispatchQueue.main.async{
                        print("401")
                        self.isError = true
                        self.errorMessage = "ERR 401: Unauthorized"
                    }
                }
                DispatchQueue.main.async{
                    self.isLoading = false
                }
                
            }catch{
                print("\(error)")
            }
        }
        
    }
    
    func loginUser(with data: Data) async throws{
//        print(data)
        guard let url = URL(string: "\(apiURL)auth/login") else { return }
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
                print("400")
                self.isError = true
                self.errorMessage = "ERR 400: Bad Reqeust"
            }
        }else if httpResponse.statusCode == 401 {
            DispatchQueue.main.async{
                print("401")
                self.isError = true
                self.errorMessage = "ERR 401: Unauthorized"
            }
        }else if httpResponse.statusCode == 404 {
            DispatchQueue.main.async{
                print("404")
                self.isError = true
                self.errorMessage = "ERR 404: Not Found"
            }
        }
        else{
            print(httpResponse.statusCode)
        }
        
        do{
            let decodedData = try JSONDecoder().decode(AuthResponse.self, from: data)
            DispatchQueue.main.async{
                UserDefaults.standard.set(decodedData.token, forKey: "token")
                UserDefaults.standard.set(decodedData.role.rawValue, forKey: "role")
            }
        }catch{
            print("\(error)")
        }
    }
}

class AdminManager: ObservableObject{
    @Published var libraries: [Library] = []
}
