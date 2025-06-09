import SwiftUI

struct FavoriteView: View {
    // Menerima BookViewModel dari environment
    @EnvironmentObject var bookViewModel: BookViewModel
    
    @State private var searchText = ""

    // Properti komputasi untuk memfilter buku favorit
    private var filteredFavoriteBooks: [Book] {
        let favoriteBooks = bookViewModel.allBooks.filter { $0.isFavorite }
        
        if searchText.isEmpty {
            return favoriteBooks
        } else {
            return favoriteBooks.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search your favorite books...", text: $searchText)
                }
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // --- PERUBAHAN UTAMA DI SINI ---
                // Mengganti LazyVGrid menjadi ScrollView dengan LazyVStack
                ScrollView {
                    LazyVStack(spacing: 15) { // Atur jarak antar item
                        ForEach(filteredFavoriteBooks) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                // Menggunakan view baru untuk tampilan list
                                BookListItem(book: book)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10) // Beri jarak dari search bar
                }
                .overlay {
                    // Tampilkan pesan jika tidak ada buku favorit
                    if filteredFavoriteBooks.isEmpty {
                        VStack {
                            Image(systemName: "heart.slash.fill")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            Text(searchText.isEmpty ? "No Favorite Books Yet" : "No Results Found")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                        }
                    }
                }
            }
            .navigationTitle("My Favorite Book")
        }
    }
}

// Struct baru untuk tampilan item dalam format daftar vertikal
struct BookListItem: View {
    @ObservedObject var book: Book
    
    var body: some View {
        HStack(spacing: 15) {
            // Tampilan Gambar
            ZStack {
                if let imageData = book.coverData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable().scaledToFill()
                } else if !book.coverAssetName.isEmpty {
                    Image(book.coverAssetName)
                        .resizable().scaledToFill()
                } else {
                    Rectangle().fill(Color.gray.opacity(0.3))
                }
            }
            .frame(width: 80, height: 120) // Ukuran sampul disesuaikan untuk list
            .clipped()
            .cornerRadius(8)
            
            // Tampilan Teks
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(book.genre)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
            
            Spacer() // Mendorong konten ke kiri
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    FavoriteView()
        .environmentObject(BookViewModel())
}
