//
//  LogoutButton.swift
//  pustak
//
//  Created by Abhay(IOS) on 03/06/24.
//

import SwiftUI
import Foundation
struct LogoutButton: View {
    var body: some View{
        Text("Logout")
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.red)
            .cornerRadius(10)
    }
}

#Preview {
    LogoutButton()
}
