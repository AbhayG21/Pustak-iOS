//
//  LibrarianMainView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct LibrarianMainView: View {
    var body: some View {
        TabView{
            LibrarianHomeView().tabItem{
                Label("Home",systemImage: "house.fill")
            }
            
            LibrarianProfileView().tabItem{
                Label("Profile",systemImage: "person.fill")
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LibrarianMainView()
}
