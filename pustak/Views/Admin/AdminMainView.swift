//
//  AdminMainView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct AdminMainView: View {
    var body: some View {
        TabView{
            AdminHomeView().tabItem{
                Label("Home",systemImage: "house.fill")
            }
            AdminLibrariansView().tabItem{
                Label("Librarians",systemImage: "person.3.fill")
            }
            AdminLibrariesView().tabItem{
                Label("Libraries",systemImage: "book.fill")
            }
            AdminProfileView().tabItem{
                Label("Profile",systemImage: "person.fill")
            }
        }.navigationBarBackButtonHidden(true)
    }
        
}

#Preview {
    AdminMainView()
}
