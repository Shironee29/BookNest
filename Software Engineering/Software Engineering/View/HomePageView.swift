//
//  HomePageView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                // Title + Add Button
                HStack {
                    Text("Book Nest")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        // Add book action
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(Color.blue)
                    }
                }
                .padding(.horizontal)

                // SearchBar Navigation Link
                NavigationLink(destination: SearchBarView()) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        Text("Search")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                // Book Sections
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        BookSection(title: "Last Read", books: dummyBooks.filter { $0.isLastRead })
                        BookSection(title: "Favorite", books: dummyBooks.filter { $0.isFavorite })
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }

    // MARK: Book Section
    func BookSection(title: String, books: [Book]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.leading, 4)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(books) { book in
                        BookItem(book: book)
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }

    // MARK: Book Item
    func BookItem(book: Book) -> some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(book.cover)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 160)
                    .clipped()
                    .cornerRadius(12)

                if book.isFavorite || book.isLastRead {
                    Image(systemName: book.isFavorite ? "bookmark.fill" : "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .padding(6)
                }
            }
            Text(book.title)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
            Text(book.author)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
        }
        .frame(width: 120)
    }
}

#Preview {
    HomePageView()
}
