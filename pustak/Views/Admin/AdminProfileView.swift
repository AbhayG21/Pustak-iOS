//
//  AdminProfileView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

import SwiftUI

struct AdminProfileView: View {
    @EnvironmentObject var userSession: UserSession
    @State private var showingLogoutAlert = false
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    ZStack{
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 150, height: 150)
                        
                        Text("Admin")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    // Profile Details
                    VStack(alignment: .center, spacing: 10) {
                        Text("Library Admin")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("admin@example.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    Button(action: {
                        showingLogoutAlert.toggle()
                    }) {
                        Text("Logout")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .alert("Are you sure you want to logout?", isPresented: $showingLogoutAlert) {
                        Button("Cancel", role: .cancel) { }
                        Button("Logout", role: .destructive) {
                             userSession.isAuthenticated = false
                        }
                    }
                    .padding(.top,12)
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Profile")
            .background(Color.customBackground)
        }
    }
}


#Preview {
    AdminProfileView()
}
