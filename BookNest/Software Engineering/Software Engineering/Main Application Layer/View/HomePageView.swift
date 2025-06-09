import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var bookViewModel: BookViewModel
    
    @State private var isShowingAddBookView = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {

                // Header with title and plus button
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

    // MARK: - Book Section (Tidak Berubah)
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
}


// MARK: - Book Item (Diubah menjadi Struct)
struct BookItem: View {
    // Gunakan @ObservedObject untuk mengamati perubahan pada objek book
    @ObservedObject var book: Book
    var showIcon: Bool

    var body: some View {
        NavigationLink(destination: BookDetailView(book: book)) {
            VStack(alignment: .leading, spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    // Logika untuk menampilkan gambar (coverData atau coverAssetName)
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
                .frame(width: 120, height: 160)
                .clipped()
                .cornerRadius(12)
                .overlay(alignment: .topTrailing) {
                    if showIcon, (book.isFavorite || book.isLastRead) {
                        Image(systemName: book.isFavorite ? "bookmark.fill" : "clock.fill")
                            .font(.caption.bold())
                            .foregroundColor(.orange)
                            .padding(6)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                            .padding(5)
                    }
                }

                // Teks judul dan penulis sekarang akan otomatis update
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
}


#Preview {
    HomePageView()
        .environmentObject(BookViewModel())
}
