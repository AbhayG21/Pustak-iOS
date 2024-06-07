//
//  AdminMainView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct AdminMainView: View {
    @EnvironmentObject var adminManager:AdminManager
    @EnvironmentObject var userSession:UserSession
    var body: some View {
        TabView{
            AdminHomeView().tabItem{
                Label("Home",systemImage: "house.fill")
            }
            AdminLibrariesView().tabItem{
                Label("Libraries",systemImage: "book.fill")
            }
            AdminProfileView()
                .tabItem{
                Label("Profile",systemImage: "person.fill")
            }
                .environmentObject(userSession)
        }
        .onAppear(perform: {
            adminManager.isLoading = true
        })
        .navigationBarBackButtonHidden(true)
    }
        
}

//#Preview {
//    AdminMainView()
//}
