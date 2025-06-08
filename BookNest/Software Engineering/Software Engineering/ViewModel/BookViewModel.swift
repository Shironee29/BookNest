import Foundation
import SwiftUI

// ViewModel untuk mengelola daftar buku
class BookViewModel: ObservableObject {
    
    @Published var allBooks: [Book] = dummyBooks
    @Published var recentlyAddedBooks: [Book] = []

    init() {
        self.recentlyAddedBooks = Array(dummyBooks.prefix(2))
    }
    
    // Fungsi addBook sekarang menerima UIImage opsional
    func addBook(title: String, author: String, genre: String, pageTotal: String, synopsis: String, coverImage: UIImage?) {
        guard !title.isEmpty, !author.isEmpty else {
            print("Error: Judul dan Penulis tidak boleh kosong.")
            return
        }
        
        let newBook = Book(
            title: title,
            author: author,
            genre: genre,
            rating: 0,
            lastPageRead: Int(pageTotal) ?? 0,
            synopsis: synopsis,
            cover: "", // Nama aset tidak relevan untuk buku baru yang gambarnya diunggah
            isFavorite: false,
            isLastRead: false
        )
        
        // Ubah UIImage menjadi Data jika ada
        if let coverImage = coverImage {
            // Kompres gambar JPEG untuk menghemat ruang penyimpanan
            newBook.coverData = coverImage.jpegData(compressionQuality: 0.8)
        }
        
        allBooks.insert(newBook, at: 0)
        recentlyAddedBooks.insert(newBook, at: 0)
        
        print("Buku baru ditambahkan dengan gambar: \(newBook.title)")
    }
}
