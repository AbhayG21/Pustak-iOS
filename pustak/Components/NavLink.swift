//
//  NavLink.swift
//  pustak
//
//  Created by Abhay(IOS) on 29/05/24.
//

import Foundation
import SwiftUI

struct NavLink:View {
    var text:String
    var cornerRadius:CGFloat
    
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .font(.system(size: 17))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.customGreen)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
