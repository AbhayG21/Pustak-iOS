//
//  logoutUser.swift
//  pustak
//
//  Created by Abhay(IOS) on 05/06/24.
//

import Foundation
func logoutUset(for userSession: UserSession){
    userSession.isAuthenticated = false
    UserDefaults.standard.set(nil, forKey: "token")
    UserDefaults.standard.set(nil, forKey: "role")
    UserDefaults.standard.set(nil, forKey: "id")
}
