import SwiftUI
import PhotosUI

struct EditBookView: View {
    // Menerima objek 'Book' yang akan diedit.
    @ObservedObject var book: Book
    
    // Environment untuk menutup tampilan (sheet) ini.
    @Environment(\.dismiss) var dismiss

    // State untuk menampung salinan data yang sedang diedit.
    @State private var editedTitle: String
    @State private var editedAuthor: String
    @State private var editedGenre: String
    @State private var editedRating: Int
    @State private var editedLastPageRead: Int
    @State private var editedSynopsis: String
    @State private var editedIsFavorite: Bool
    
    // State BARU untuk menangani gambar yang diedit.
    @State private var newCoverImage: UIImage?
    @State private var photoItem: PhotosPickerItem?

    // Initializer untuk mengisi @State dengan data dari objek 'book'
    init(book: Book) {
        self.book = book
        // Menginisialisasi setiap @State dengan nilai awal dari 'book'
        _editedTitle = State(initialValue: book.title)
        _editedAuthor = State(initialValue: book.author)
        _editedGenre = State(initialValue: book.genre)
        _editedRating = State(initialValue: book.rating)
        _editedLastPageRead = State(initialValue: book.lastPageRead)
        _editedSynopsis = State(initialValue: book.synopsis)
        _editedIsFavorite = State(initialValue: book.isFavorite)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) { // Menambah jarak antar elemen
                    
                    // MARK: - Editable Cover Image
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        VStack {
                            // Logika untuk menampilkan gambar yang sudah ada atau yang baru dipilih
                            if let newImage = newCoverImage {
                                Image(uiImage: newImage)
                                    .resizable().scaledToFit()
                            } else if let imageData = book.coverData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable().scaledToFit()
                            } else if !book.coverAssetName.isEmpty {
                                Image(book.coverAssetName)
                                    .resizable().scaledToFit()
                            } else {
                                // Placeholder jika tidak ada gambar sama sekali
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(height: 225)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .overlay(
                            Image(systemName: "pencil.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.black.opacity(0.4), in: Circle()),
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
                    .padding(.bottom, 10)

                    // Form yang bisa diedit
                    VStack(alignment: .leading, spacing: 20) {
                        // Judul & Penulis
                        EditableTextField(label: "Title", text: $editedTitle, font: .title.bold())
                        EditableTextField(label: "Author", text: $editedAuthor, font: .title2.weight(.medium), color: .secondary)
                        
                        // Genre
                        EditableTextField(label: "Genre", text: $editedGenre, prompt: "Enter genre")
                        
                        // Rating
                        HStack {
                            Text("Rating :").font(.headline)
                            EditableRating(rating: $editedRating)
                        }
                        
                        // Halaman Terakhir Dibaca
                        HStack {
                            Text("Last Read :").font(.headline)
                            TextField("Page", value: $editedLastPageRead, format: .number)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 80)
                        }

                        // Sinopsis
                        VStack(alignment: .leading) {
                            Text("Synopsis :").font(.headline)
                            TextEditor(text: $editedSynopsis)
                                .frame(minHeight: 150)
                                .padding(4)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4), lineWidth: 1))
                        }

                        // Toggle untuk Favorit
                        Toggle("Mark as Favorite", isOn: $editedIsFavorite)
                            .font(.headline)
                            .tint(.pink)

                    }
                    .padding(.horizontal)
                }
                .padding(.top, 20)
            }
            .navigationTitle("Edit Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Simpan semua perubahan
                        book.title = editedTitle
                        book.author = editedAuthor
                        book.genre = editedGenre
                        book.rating = editedRating
                        book.lastPageRead = editedLastPageRead
                        book.synopsis = editedSynopsis
                        book.isFavorite = editedIsFavorite
                        
                        // Jika pengguna memilih gambar baru, perbarui coverData
                        if let newCoverImage = newCoverImage {
                            book.coverData = newCoverImage.jpegData(compressionQuality: 0.8)
                        }
                        
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Sub-views untuk Edit

// View pembantu untuk field yang bisa diedit
struct EditableTextField: View {
    var label: String
    @Binding var text: String
    var prompt: String?
    var font: Font = .body
    var color: Color = .primary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label.uppercased())
                .font(.caption)
                .foregroundColor(.gray)
            TextField(prompt ?? label, text: $text)
                .font(font)
                .foregroundColor(color)
        }
    }
}

// View pembantu untuk rating yang bisa diedit
struct EditableRating: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index > rating ? "star" : "star.fill")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}

#Preview {
    EditBookView(book: Book.example)
}
