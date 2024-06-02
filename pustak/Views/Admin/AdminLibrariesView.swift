//
//  AdminLibrariesView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct AdminLibrariesView: View {
//    @EnvironmentObject var auth:AuthNetworkManager
    @EnvironmentObject var libraryManager:AdminManager
    @State var isShowingAddItemView = false
    var body: some View {
        NavigationStack{
        if(libraryManager.isLoading){
            ProgressView()
                .onAppear(perform: {
                    Task{
                        do{
                            try await libraryManager.fetchLibrary()
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
            if(libraryManager.libraries.count == 0){
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
                    List(libraryManager.libraries){library in
                        HStack{
                            VStack(alignment: .leading, spacing: -4){
                                Text(library.libraryName)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .font(.title2)
                                Text(library.libraryEmail)
                                    .fontWeight(.regular)
                                    .fontDesign(.rounded)
                            }
                            Spacer()
                        }
                    }
                    .navigationTitle("Home")
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
