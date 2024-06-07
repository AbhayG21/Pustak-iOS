//
//  CurretnStockCard.swift
//  pustak
//
//  Created by Abhay(IOS) on 07/06/24.
//

import SwiftUI

struct CurrentStockCard: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("Current Stock")
                .padding()
                .font(.title2)
                .foregroundColor(.black)
            Image("book1")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 150)
                .shadow(radius: 10)
                .padding([.top, .bottom], 30)
        }
        .background(Color(red: 228 / 255, green: 226 / 255, blue: 217 / 255))
        .cornerRadius(10)
    }
}

//#Preview {
//    CurrentStockCard()
//}
