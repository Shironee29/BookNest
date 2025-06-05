import SwiftUI

struct BookDetailView: View {
    @ObservedObject var book: Book
    @State private var showingEditSheet = false // State to control the presentation of the edit sheet

    var body: some View {
        ScrollView { // Use ScrollView to allow content to scroll if it exceeds screen height
            VStack(alignment: .leading, spacing: 15) {
                // Book Cover Image
                if !book.cover.isEmpty {
                    Image(book.cover) // Assuming 'book.cover' is the name of an image in your Asset Catalog
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 225) // Adjust size as needed
                        .cornerRadius(8)
                        .shadow(radius: 5)
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity, alignment: .center) // Center the image
                }

                // Title and Favorite Button
                HStack {
                    Text(book.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(book.isFavorite ? .red : .gray)
                        .font(.title2)
                        .onTapGesture {
                            book.isFavorite.toggle() // Toggle favorite status
                        }
                }
                .padding(.horizontal)

                // Author
                Text(book.author)
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                // Genre
                HStack {
                    Text("Genre :")
                        .font(.headline)
                    Text(book.genre)
                        .font(.body)
                }
                .padding(.horizontal)

                // Rating
                HStack {
                    Text("Rating :")
                        .font(.headline)
                    // Display stars based on rating
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= book.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .padding(.horizontal)

                // Last Read
                HStack {
                    Text("Last Read :")
                        .font(.headline)
                    Text("Page \(book.lastPageRead)")
                        .font(.body)
                }
                .padding(.horizontal)

                // Synopsis
                VStack(alignment: .leading) {
                    Text("Synopsis :")
                        .font(.headline)
                        .padding(.bottom, 2)
                    Text(book.synopsis)
                        .font(.body)
                        .lineLimit(nil) // Allows multiple lines
                        .padding(.bottom, 10)
                }
                .padding(.horizontal)
            }
            .padding(.top, 20) // Add some top padding for overall content
        }
        .navigationTitle("Book Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditSheet = true // Show the edit sheet
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditBookView(book: book) // Present the EditBookView
        }
    }
}

// Add a preview for BookDetailView
struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookDetailView(book: Book.example)
        }
    }
}

