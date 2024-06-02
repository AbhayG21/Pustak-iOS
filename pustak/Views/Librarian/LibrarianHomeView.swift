//
//  LibrarianHomeView.swift
//  pustak
//
//  Created by Abhay(IOS) on 01/06/24.
//

import SwiftUI

struct LibrarianHomeView: View {
    @State private var showAddNewBookView: Bool = false
    
    @State private var bookImages: [UIImage] = Array(repeating: UIImage(named: "bookCover")!, count: 10)
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
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
                    
                    VStack(alignment: .leading) {
                        Text("Top picks")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 50) {
                                ForEach(0..<bookImages.count, id: \.self) { index in
                                    VStack {
                                        ZStack(alignment: .topLeading) {
                                            Image(uiImage: bookImages[index])
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 120, height: 200)
                                            
                                            Text("\(index + 1)")
                                                .font(.custom("TimesNewRoman", size: 100))
                                                .bold()
                                                .foregroundColor(.accentColor)
                                                .offset(x: -65, y: -40)
                                                .padding()
                                        }
                                    }
                                    .padding([.leading], 5)
                                }
                            }
                            .padding([.leading], 50)
                            .padding([.top, .bottom], 10)
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Top-6 categories")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        VStack {
                            HStack {
                                CategoryTile(title: "Fantasy")
                                CategoryTile(title: "Science")
                            }
                            HStack {
                                CategoryTile(title: "Romance")
                                CategoryTile(title: "Kids Story")
                            }
                            HStack {
                                CategoryTile(title: "Mystery")
                                CategoryTile(title: "Horror")
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Library")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddNewBookView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddNewBookView) {
                AddBookView()
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

#Preview {
    LibrarianHomeView()
}
