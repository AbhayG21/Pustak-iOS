//
//  CurrentStockView.swift
//  pustak
//
//  Created by Abhay(IOS) on 07/06/24.
//

import SwiftUI

struct CurrentStockView: View {
    @EnvironmentObject var getBooksManager: LibrarianFetchBookManager
    var libraryId:String
    var body: some View {
        List{
            ForEach(getBooksManager.books){ book in
                LibrarianBookCard(book:book)
            }
        }.onAppear(perform: {
            Task{
                do{
                try await getBooksManager.fetchBooks(with: UUID(uuidString: "FEDB854F-9473-448F-A1C3-D7CFBBBC325A")!)
                }
            }
        })
        .navigationTitle("Current Stock")
    }
}

//#Preview {
//    CurrentStockView()
//}
