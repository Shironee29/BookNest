import SwiftUI

struct BookDetailView: View {
    // Menerima objek Book yang akan ditampilkan
    @ObservedObject var book: Book
    
    @State private var showingEditSheet = false // State untuk menampilkan sheet edit

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // MARK: - Book Cover Image (Diperbaiki)
                
                // --- PERBAIKAN LOGIKA GAMBAR DI SINI ---
                // Logika ini akan menampilkan gambar dari data yang diunggah jika ada,
                // jika tidak, ia akan mencoba menampilkan dari nama aset (untuk dummy data).
                if let imageData = book.coverData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity) // Agar gambar bisa lebih besar dan tetap di tengah
                } else if !book.coverAssetName.isEmpty {
                    Image(book.coverAssetName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } else {
                    // Placeholder jika tidak ada gambar sama sekali
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 225)
                        .overlay(Image(systemName: "photo.on.rectangle.angled"))
                }
            }
            .frame(height: 225) // Beri tinggi tetap pada frame gambar
            .cornerRadius(8)
            .shadow(radius: 5)
            .padding(.horizontal, 80) // Beri padding horizontal agar tidak terlalu lebar
            .padding(.vertical, 10)

            VStack(alignment: .leading, spacing: 15) {
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
                            book.isFavorite.toggle() // Langsung mengubah status favorit
                        }
                }

                // Author
                Text(book.author)
                    .font(.title2)
                    .foregroundColor(.secondary)

                // Genre
                HStack {
                    Text("Genre:")
                        .font(.headline)
                    Text(book.genre)
                        .font(.body)
                }

                // Rating
                HStack {
                    Text("Rating:")
                        .font(.headline)
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= book.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                }

                // Last Read
                HStack {
                    Text("Last Read:")
                        .font(.headline)
                    Text("Page \(book.lastPageRead)")
                        .font(.body)
                }

                // Synopsis
                VStack(alignment: .leading) {
                    Text("Synopsis:")
                        .font(.headline)
                        .padding(.bottom, 2)
                    Text(book.synopsis)
                        .font(.body)
                }
            }
            .padding(.horizontal) // Padding untuk semua konten teks
            
        }
        .navigationTitle("Book Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditSheet = true // Tampilkan sheet edit
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            // Pastikan EditBookView juga sudah diperbarui untuk model Book yang baru
            EditBookView(book: book)
        }
    }
}

// Preview memerlukan NavigationView untuk menampilkan judul dan tombol toolbar
#Preview {
    NavigationView {
        BookDetailView(book: Book.example)
    }
}
