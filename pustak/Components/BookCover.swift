//
//  BookCover.swift
//  pustak
//
//  Created by Abhay(IOS) on 07/06/24.
//

import Foundation
import SwiftUI

enum FontStyleType{
    case title
    case title2
    case title3
    case caption
    case body
    
    var font: Font{
        switch self{
        case .title:
            return .title
        case .body:
            return .body
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .caption:
            return .caption
        }
        
    }
}
struct VerticalDivider: View{
    var x: CGFloat = 1
//    var y: CGFloat = 1
    var body: some View{
        Rectangle().fill(Color.customBrown.opacity(0.8))
            .frame(width: x)
    }
    
}

struct BookCover: View{
    var bookName:String
    var authName:String
    var width: CGFloat = 50
    var height: CGFloat = 60
    var BnamefontType: FontStyleType = .title
    var BauthorfontType: FontStyleType = .caption
    
    
    var body: some View{
//        var bookCoverColor:[Color] = [Color.cyan, Color.red, Color.orange]
        var lineargradients: [LinearGradient] = [
            LinearGradient(colors: [.customText, .customToggleText], startPoint: .topLeading, endPoint: .bottomTrailing)
        ]
       
        
        let randomColor = lineargradients.randomElement()
        HStack{
            VStack(alignment: .leading){
                VerticalDivider().frame(height: height - 5 )
                
            }
            .padding(.leading,3)
            
            VStack(alignment: .leading){
                Text("\(bookName)")
                    .font(.system(size:10))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.top).padding(.trailing,2).padding(.leading, 5)
                Spacer()
                Text("\(authName)")
                    .font(.system(size: 8))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                    .padding(.leading, 5)
//                Spacer()
                
            }
        }.frame(width: width, height: height).background(randomColor)
    }
}

//#Preview{
//    BookCover(bookName: "A day in life of Anushka", authName: "Amol", width: 150, height: 200)
//}
