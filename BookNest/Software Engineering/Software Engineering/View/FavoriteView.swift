import SwiftUI

struct FavoriteView: View {
    // 1. Menerima BookViewModel dari environment
    // Ini adalah sumber data utama yang dibagikan ke seluruh aplikasi.
    @EnvironmentObject var bookViewModel: BookViewModel
    
    // State untuk menampung teks pencarian
    @State private var searchText = ""

    // Properti komputasi untuk memfilter buku favorit berdasarkan teks pencarian
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
    
    // Definisi kolom untuk grid
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        // Gunakan NavigationStack untuk judul dan navigasi di masa depan
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 12)
                    
                    TextField("Search your favorite books...", text: $searchText)
                        .padding(.vertical, 10)
                }
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Grid of Favorite Books
                ScrollView {
                    // 2. Gunakan 'filteredFavoriteBooks' yang sudah difilter
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(filteredFavoriteBooks) { book in
                            // 3. Bungkus setiap item dengan NavigationLink agar bisa diklik
                            NavigationLink(destination: BookDetailView(book: book)) {
                                VStack(spacing: 8) {
                                    // Logika untuk menampilkan gambar (coverData atau coverAssetName)
                                    if let imageData = book.coverData, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable().scaledToFill()
                                    } else {
                                        Image(book.coverAssetName)
                                            .resizable().scaledToFill()
                                    }
                                }
                                .frame(width: 120, height: 180)
                                .background(Color.gray.opacity(0.3))
                                .clipped()
                                .cornerRadius(10)
                                
                                Text(book.title)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary) // Pastikan teks bisa dibaca
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                
                                Text(book.author)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .frame(width: 140)
                        }
                    }
                    .padding()
                }
                
                // Overlay jika tidak ada buku favorit
                if filteredFavoriteBooks.isEmpty {
                    VStack {
                        Spacer()
                        Image(systemName: "heart.slash.fill")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text(searchText.isEmpty ? "No Favorite Books Yet" : "No Results Found")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("My Favorite Book")
        }
    }
}

#Preview {
    FavoriteView()
        // Sediakan BookViewModel untuk preview agar tidak crash
        .environmentObject(BookViewModel())
}
