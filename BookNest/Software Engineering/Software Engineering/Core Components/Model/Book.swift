import Foundation
import SwiftUI

// Diperbarui agar bisa menyimpan data gambar
class Book: ObservableObject, Identifiable {
    let id = UUID()
    @Published var title: String
    @Published var author: String
    @Published var genre: String
    @Published var rating: Int
    @Published var lastPageRead: Int
    @Published var synopsis: String
    
    // Properti LAMA untuk nama aset gambar (digunakan oleh dummy data)
    @Published var coverAssetName: String
    
    // Properti BARU untuk menyimpan data gambar yang diunggah pengguna
    @Published var coverData: Data?
    
    @Published var isFavorite: Bool
    @Published var isLastRead: Bool

    // Initializer diperbarui untuk properti baru
    init(title: String, author: String, genre: String, rating: Int, lastPageRead: Int, synopsis: String, cover: String, isFavorite: Bool, isLastRead: Bool) {
        self.title = title
        self.author = author
        self.genre = genre
        self.rating = rating
        self.lastPageRead = lastPageRead
        self.synopsis = synopsis
        self.coverAssetName = cover // Menggunakan properti baru untuk nama aset
        self.isFavorite = isFavorite
        self.isLastRead = isLastRead
        // coverData secara default nil
    }

    // Example Static Data tetap sama untuk preview
    static let example = Book(
        title: "Bridge of Clay",
        author: "Markus Zusak",
        genre: "Literary Fiction",
        rating: 3,
        lastPageRead: 100,
        synopsis: "Five brothers bring each other up in the wake of their parents’ disappearance, and one builds a bridge that will bring them together.",
        cover: "bridge",
        isFavorite: true,
        isLastRead: false
    )
}
