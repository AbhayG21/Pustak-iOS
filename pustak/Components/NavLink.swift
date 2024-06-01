//
//  NavLink.swift
//  pustak
//
//  Created by Abhay(IOS) on 29/05/24.
//

import Foundation
import SwiftUI

import Foundation
import SwiftUI

struct NavLink: View {
    var text: String
    var cornerRadius: CGFloat
    var body: some View {
        if(text=="Sign Up"){
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.customText)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        else{
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(.customText)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        
    }
}
#Preview{
    InitialView()
}
