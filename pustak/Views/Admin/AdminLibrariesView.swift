//
//  AdminLibrariesView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct AdminLibrariesView: View {
    //    @EnvironmentObject var auth:AuthNetworkManager
    @EnvironmentObject var userSession:UserSession
    @EnvironmentObject var adminManager:AdminManager
    @State var isShowingAddItemView = false
    var body: some View {
        NavigationStack{
            if(adminManager.isLoading){
                ProgressView()
                    .onAppear(perform: {
                        Task{
                            do{
                                try await adminManager.fetchLibrary(with:userSession.uId)
                            }
                            catch{}
                        }
                    })
                    .navigationTitle("Home")
                    .toolbar{
                        Button(action: {
                            isShowingAddItemView = true
                        }){
                            Image(systemName: "plus")
                        }
                    }
            }else{
                if(adminManager.libraries.count == 0){
                    VStack (spacing: 12){
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .opacity(0.25)
                        Text("No data to display")
                            .fontDesign(.rounded)
                            .fontWeight(.medium)
                            .font(.title3)
                            .opacity(0.5)
                    }
                    .navigationTitle("Home")
                    .toolbar{
                        Button(action: {
                            isShowingAddItemView = true
                        }){
                            Image(systemName: "plus")
                        }
                    }
                }else{
                    ScrollView{
                        VStack(spacing: 10) {
                            ForEach(adminManager.libraries) { library in
                                
                                LibraryCard(library: library)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .navigationTitle("Libraries")
                    .toolbar{
                        Button(action: {
                            isShowingAddItemView = true
                        }){
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingAddItemView, content: {
            AddLibrary()
        })
    }
}

//#Preview {
//    AdminLibrariesView()
//}
