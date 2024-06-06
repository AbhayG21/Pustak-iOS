//
//  getData.swift
//  pustak
//
//  Created by Abhay(IOS) on 04/06/24.
//

import Foundation
import SwiftUI

func getSetData(type: String, endpoint:String, token:String? = nil, body:Data? = nil, queryParams:[String:String]? = nil) async throws -> Data?{
    let urlPath = "\(apiURL)\(endpoint)"
    guard var urlComponenets = URLComponents(string:urlPath) else {return nil}
    
    if type == "GET", let queryParams = queryParams{
        urlComponenets.queryItems = queryParams.map{
            URLQueryItem(name: $0.key, value: $0.value)
        }
    }
    
    let url = urlComponenets.url!
    var request = URLRequest(url: url)
    request.httpMethod = type
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    if let token = token{
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    
    if let body = body, type == "POST" {
        request.httpBody = body
    }
    
    
    do{
        let (data,response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {throw ErrorResponse.serverError}
        
        switch response.statusCode{
        case 400:
            print("jsavdfhbkj1")
            throw ErrorResponse.badRequest
        case 401:
            print("jsavdfhbkj2")
            throw ErrorResponse.detailsMismatch
        case 409:
            print("jsavdfhbkj4")
            throw ErrorResponse.alreadyExists
        case 500:
            print("jsavdfhbkj5")
            throw ErrorResponse.serverError
        case 404:
            print("jsavdfhbkj6")
            throw ErrorResponse.notFound
        default:
            print(response.statusCode)
            break;
        }
        return data
    }catch{
        throw error
    }
}

