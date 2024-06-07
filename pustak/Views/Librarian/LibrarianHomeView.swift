//
//  LibrarianHomeView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct LibrarianHomeView: View {
    @EnvironmentObject var getBookManager: LibrarianFetchBookManager
    @EnvironmentObject var userSession:UserSession
    @StateObject var getLibraryManager = GetLibraryManager()
    @State private var showAddNewBookView: Bool = false
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    NavigationLink(destination:CurrentStockView(libraryId:getLibraryManager.libraryId)){
                        CurrentStockCard()
                            .environmentObject(getBookManager)
                    }
                    
                    Button(action: {
                        showAddNewBookView = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 20, weight: .medium))
                            Text("Add Book")
                                .font(.system(size: 20, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .foregroundColor(.white)
                        .background(Color.customBrown)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Library")
            .sheet(isPresented: $showAddNewBookView) {
                AddBookView(libraryId:getLibraryManager.libraryId)
            }
        }
        .onAppear{
            Task{
                do{
                    try await getLibraryManager.getLibraryId(with: userSession.uId)
                    
                }catch{}
            }
        }
        
    }
}


struct CategoryTile: View {
    var title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 228 / 255, green: 226 / 255, blue: 217 / 255))
                .frame(width: 150, height: 100)
            Text(title)
                .font(.title3)
                .foregroundColor(.black)
        }
        .padding([.trailing], 15)
    }
}

//#Preview {
//    LibrarianHomeView()
//}
