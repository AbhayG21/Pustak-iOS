//
//  LibrarianMainView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct LibrarianMainView: View {
    @EnvironmentObject var libraryManager:AdminManager
    var body: some View {
        TabView{
            LibrarianHomeView().tabItem {
                Label("Library", systemImage: "books.vertical.fill")
            }
            LibrarianHomeView().tabItem {
                Label("Requests", systemImage: "tray.and.arrow.down.fill")
            }
            LibrarianHomeView().tabItem {
                Label("Members", systemImage: "person.2.fill")
            }
            LibrarianHomeView().tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
        .onAppear(perform: {
            libraryManager.isLoading = true
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LibrarianMainView()
}
