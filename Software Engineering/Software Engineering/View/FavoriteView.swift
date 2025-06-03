//
//  BookmarkView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI

struct FavoriteView: View {
    let books: [Book] = [
        Book(title: "The Hobbit", author: "J. R. R. Tolkien", cover: "hobbit", isFavorite: true, isLastRead: false),
        Book(title: "Catching Fire", author: "Suzanne Collins", cover: "catching_fire", isFavorite: true, isLastRead: false),
        Book(title: "A Man Called Ove", author: "Fredrik Backman", cover: "ove", isFavorite: true, isLastRead: false),
        Book(title: "Bridge of Clay", author: "Markus Zusak", cover: "bridge_of_clay", isFavorite: true, isLastRead: false),
        Book(title: "The Borgias", author: "Christopher Hibbert", cover: "borgias", isFavorite: false, isLastRead: false),
        Book(title: "The Word is Murder", author: "Anthony Horowitz", cover: "word_is_murder", isFavorite: true, isLastRead: false)
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                // Title & Back Button
                HStack {
                    Button(action: {
                        // Back action if needed
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                    
                    Text("My Favorite Book")
                        .font(.title2)
                        .bold()
                }
                .padding(.horizontal)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .padding(.leading, 12)
                    
                    TextField("Search", text: .constant(""))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                }
                .background(Color.yellow)
                .cornerRadius(30)
                .padding(.horizontal)
                
                // Grid of Favorite Books
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(books.filter { $0.isFavorite }) { book in
                            VStack(spacing: 8) {
                                Image(book.cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 180)
                                    .clipped()
                                    .cornerRadius(10)
                                
                                Text(book.title)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                
                                Text(book.author)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 140)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.top)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    FavoriteView()
}
