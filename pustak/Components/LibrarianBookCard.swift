//
//  LibrarianBookCard.swift
//  pustak
//
//  Created by Abhay(IOS) on 07/06/24.
//

import SwiftUI

struct LibrarianBookCard: View {
    var book:Books
    var body: some View {
        NavigationLink(destination: EmptyView()) {
                    HStack(spacing: 16) {
                        BookCover(bookName: "\(book.title)", authName: "\(book.author)", width: 70, height: 90, BnamefontType: .caption)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(book.title)")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("\(book.author)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.secondary)
                    }
                    .tint(.customBrown)
//                    .padding()
//                    .background(Color(UIColor.secondarySystemBackground))
//                    .cornerRadius(10)
//                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
    }
}

//#Preview {
//    LibrarianBookCard()
//}
