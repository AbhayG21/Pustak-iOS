//
//  AssignButton.swift
//  pustak
//
//  Created by Abhay(IOS) on 03/06/24.
//

import SwiftUI

import SwiftUI

struct AssignButton: View {
    @State var isPresented = false
    var library:Library
    var body: some View {
            
            Button("Assign") {
                isPresented = true
            }
            .buttonStyle(.bordered)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .tint(.customToggleText)
            .padding()
            .sheet(isPresented: $isPresented, content: {
                AssignLibrarian(library:library)
                
            })
    }
}

//#Preview {
//    AssignButton()
//}
