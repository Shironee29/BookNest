//
//  BookmarkView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI

struct FavoriteView: View {
    let books: [Book] = [
        Book(
            title: "The Hobbit",
            author: "J. R. R. Tolkien",
            genre: "Fantasy",
            rating: 5,
            lastPageRead: 310,
            synopsis: "A hobbit named Bilbo Baggins goes on an unexpected journey with a group of dwarves to reclaim their homeland from a dragon.",
            cover: "hobbit",
            isFavorite: false,
            isLastRead: true
        ),
        Book(
            title: "Catching Fire",
            author: "Suzanne Collins",
            genre: "Dystopian",
            rating: 4,
            lastPageRead: 200,
            synopsis: "Katniss Everdeen finds herself back in the deadly arena as unrest spreads across the districts of Panem.",
            cover: "catching_fire",
            isFavorite: false,
            isLastRead: true
        ),
        Book(
            title: "A Man Called Ove",
            author: "Fredrik Backman",
            genre: "Drama",
            rating: 4,
            lastPageRead: 150,
            synopsis: "A grumpy yet lovable old man’s life changes when new neighbors move in and upend his routine.",
            cover: "ove",
            isFavorite: false,
            isLastRead: true
        ),
        Book(
            title: "Bridge of Clay",
            author: "Markus Zusak",
            genre: "Literary Fiction",
            rating: 3,
            lastPageRead: 100,
            synopsis: "Five brothers bring each other up in the wake of their parents’ disappearance, and one builds a bridge that will bring them together.",
            cover: "bridge",
            isFavorite: true,
            isLastRead: false
        ),
        Book(
            title: "The Borgias",
            author: "Christopher Hibbert",
            genre: "Historical",
            rating: 4,
            lastPageRead: 220,
            synopsis: "A fascinating biography that unravels the scandalous lives of one of Italy’s most infamous dynasties.",
            cover: "borgias",
            isFavorite: true,
            isLastRead: false
        ),
        Book(
            title: "The Word is Murder",
            author: "Anthony Horowitz",
            genre: "Mystery",
            rating: 5,
            lastPageRead: 280,
            synopsis: "A brilliant detective story where the author becomes a character, investigating a murder alongside a disgraced detective.",
            cover: "murder",
            isFavorite: true,
            isLastRead: false
        )
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
