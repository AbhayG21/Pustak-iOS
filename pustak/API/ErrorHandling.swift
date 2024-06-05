//
//  ErrorHandling.swift
//  pustak
//
//  Created by Abhay(IOS) on 05/06/24.
//

import Foundation

protocol ErrorHandling:ObservableObject{
    var isError:Bool {get set}
    var errorMessage:String{get set}
}
extension ErrorHandling{
    func errorHandler(_ error:ErrorResponse){
        switch error {
        case .alreadyExists:
            DispatchQueue.main.async {
                self.isError = true
                self.errorMessage = "Error 409: Entry already exists"
            }
        case .notFound:
            DispatchQueue.main.async {
                self.isError = true
                self.errorMessage = "Error 404: The requested resource could not be found."
            }
        case .badRequest:
            DispatchQueue.main.async {
                self.isError = true
                self.errorMessage = "Error 400: Invalid request."
            }
            
        case .serverError:
            DispatchQueue.main.async {
                self.isError = true
                self.errorMessage = "Error 500: An unexpected error occurred on the server."
            }
        case .noData:
            DispatchQueue.main.async {
                self.isError = true
                self.errorMessage = "No data retrieved."
            }
            
        case .detailsMismatch:
            DispatchQueue.main.async {
                self.isError = true
                self.errorMessage = "Error 401: Mismatched details."
            }
        }
    }
}
enum ErrorResponse:Error{
    case alreadyExists
    case notFound
    case badRequest
    case serverError
    case noData
    case detailsMismatch
}
