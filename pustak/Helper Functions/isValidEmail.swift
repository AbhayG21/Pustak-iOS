//
//  isValidEmail.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import Foundation

//Check if email entered by user is belongs to Infosys
func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    let boolVal = emailPredicate.evaluate(with: email) && email.contains("infy.com")
    return boolVal
}
