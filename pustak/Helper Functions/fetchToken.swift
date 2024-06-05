//
//  fetchToken.swift
//  pustak
//
//  Created by Abhay(IOS) on 05/06/24.
//

import Foundation

func fetchToken() throws -> String{
    guard let token = UserDefaults.standard.object(forKey: "token") as? String else { throw ErrorResponse.noData }
        return token
}
