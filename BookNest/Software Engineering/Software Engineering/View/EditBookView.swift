import SwiftUI
import PhotosUI

struct EditBookView: View {
    @ObservedObject var book: Book
    @Environment(\.dismiss) var dismiss

    // State untuk menampung data yang diedit
    @State private var editedTitle: String
    @State private var editedAuthor: String
    @State private var editedGenre: String
    @State private var editedRating: Int
    @State private var editedLastPageRead: Int
    @State private var editedSynopsis: String
    @State private var editedIsFavorite: Bool
    @State private var editedIsLastRead: Bool
    
    // State BARU untuk menangani gambar yang diedit
    @State private var newCoverImage: UIImage?
    @State private var photoItem: PhotosPickerItem?

    init(book: Book) {
        self.book = book
        // Inisialisasi semua @State dari objek buku asli
        _editedTitle = State(initialValue: book.title)
        _editedAuthor = State(initialValue: book.author)
        _editedGenre = State(initialValue: book.genre)
        _editedRating = State(initialValue: book.rating)
        _editedLastPageRead = State(initialValue: book.lastPageRead)
        _editedSynopsis = State(initialValue: book.synopsis)
        _editedIsFavorite = State(initialValue: book.isFavorite)
        _editedIsLastRead = State(initialValue: book.isLastRead)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    
                    // MARK: - Editable Cover Image
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        VStack {
                            // Logika untuk menampilkan gambar yang sudah ada atau yang baru dipilih
                            if let newImage = newCoverImage {
                                Image(uiImage: newImage)
                                    .resizable().scaledToFill()
                            } else if let imageData = book.coverData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable().scaledToFill()
                            } else {
                                Image(book.coverAssetName)
                                    .resizable().scaledToFill()
                            }
                        }
                        .frame(width: 150, height: 225)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                        .shadow(radius: 5)
                        .overlay(
                            Image(systemName: "pencil.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.5), in: Circle())
                                .padding(5),
                            alignment: .bottomTrailing
                        )
                    }
                    .onChange(of: photoItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                newCoverImage = uiImage
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    // ... (Form input lainnya tetap sama) ...
                    
                    HStack {
                        TextField("Title", text: $editedTitle)
                            // ... styling ...
                    }
                    .padding(.horizontal)

                    // ... (Sisa form input) ...
                }
                .padding(.top, 20)
            }
            .navigationTitle("Edit Book Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Salin semua perubahan dari @State kembali ke objek 'book'
                        book.title = editedTitle
                        book.author = editedAuthor
                        book.genre = editedGenre
                        book.rating = editedRating
                        book.lastPageRead = editedLastPageRead
                        book.synopsis = editedSynopsis
                        book.isFavorite = editedIsFavorite
                        book.isLastRead = editedIsLastRead
                        
                        // Jika pengguna memilih gambar baru, perbarui coverData
                        if let newCoverImage = newCoverImage {
                            book.coverData = newCoverImage.jpegData(compressionQuality: 0.8)
                        }
                        
                        dismiss() // Tutup halaman setelah menyimpan
                    }
                }
            }
        }
    }
}

#Preview {
    EditBookView(book: Book.example)
}
