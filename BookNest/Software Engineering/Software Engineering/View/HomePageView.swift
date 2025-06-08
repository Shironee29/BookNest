import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var bookViewModel: BookViewModel
    
    @State private var isShowingAddBookView = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {

                // Header
                HStack {
                    Text("Book Nest")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        isShowingAddBookView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(Color.orange)
                    }
                    .sheet(isPresented: $isShowingAddBookView) {
                        AddBookView()
                            .environmentObject(bookViewModel)
                    }
                }
                .padding(.horizontal)

                // Search Bar
                NavigationLink(destination: SearchBarView()) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        Text("Search books...")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }

                // Book Sections
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        BookSection(title: "Last Read", books: bookViewModel.allBooks.filter { $0.isLastRead }, showIcon: true)
                        BookSection(title: "Favorites", books: bookViewModel.allBooks.filter { $0.isFavorite }, showIcon: true)
                        BookSection(title: "Recently Added", books: bookViewModel.recentlyAddedBooks, showIcon: false)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }

    // MARK: - Book Section
    @ViewBuilder
    func BookSection(title: String, books: [Book], showIcon: Bool) -> some View {
        if !books.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(books) { book in
                            BookItem(book: book, showIcon: showIcon)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        } else {
            EmptyView()
        }
    }

    // MARK: - Book Item (Posisi Ikon Diperbaiki)
    @ViewBuilder
    func BookItem(book: Book, showIcon: Bool) -> some View {
        NavigationLink(destination: BookDetailView(book: book)) {
            VStack(alignment: .leading, spacing: 6) {
                
                // Gunakan ZStack agar bisa menumpuk ikon di atas gambar
                ZStack(alignment: .topTrailing) { // Atur alignment ke kanan atas
                    
                    // Gambar Sampul (logika tidak berubah)
                    if let imageData = book.coverData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(book.coverAssetName)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 120, height: 160)
                .background(Color.gray.opacity(0.3))
                .clipped()
                .cornerRadius(12)
                // --- PERBAIKAN UTAMA DI SINI ---
                // Tambahkan .overlay untuk menempatkan ikon di atas ZStack sebelumnya
                .overlay(alignment: .topTrailing) {
                    // Tampilkan ikon HANYA jika showIcon true
                    if showIcon, (book.isFavorite || book.isLastRead) {
                        Image(systemName: book.isFavorite ? "bookmark.fill" : "clock.fill")
                            .font(.caption.bold()) // Sedikit perkecil ikon
                            .foregroundColor(.orange)
                            .padding(6)
                            .background(Color.black.opacity(0.5)) // Latar belakang agar kontras
                            .clipShape(Circle())
                            .padding(5) // Jarak dari sudut kanan atas
                    }
                }
                
                // Teks judul dan penulis (tidak berubah)
                Text(book.title).font(.subheadline).fontWeight(.medium).lineLimit(1)
                Text(book.author).font(.caption).foregroundColor(.gray).lineLimit(1)
            }
            .frame(width: 120)
        }
    }
}

#Preview {
    HomePageView()
        .environmentObject(BookViewModel())
}
