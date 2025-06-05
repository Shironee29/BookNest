import Foundation
import SwiftUI // Import SwiftUI for Image, etc. if you haven't already

class Book: ObservableObject, Identifiable {
    let id = UUID() // For identifiable
    @Published var title: String
    @Published var author: String
    @Published var genre: String
    @Published var rating: Int // 0-5
    @Published var lastPageRead: Int
    @Published var synopsis: String
    @Published var cover: String // Image name (moved to match your dummy data order)
    @Published var isFavorite: Bool
    @Published var isLastRead: Bool

    // Updated initializer to match the dummy data order
    init(title: String, author: String, genre: String, rating: Int, lastPageRead: Int, synopsis: String, cover: String, isFavorite: Bool, isLastRead: Bool) {
        self.title = title
        self.author = author
        self.genre = genre
        self.rating = rating
        self.lastPageRead = lastPageRead
        self.synopsis = synopsis
        self.cover = cover
        self.isFavorite = isFavorite
        self.isLastRead = isLastRead
    }

    // Example Static Data for Preview (updated to match your dummy data 'Bridge of Clay')
    static let example = Book(
        title: "Bridge of Clay",
        author: "Markus Zusak",
        genre: "Literary Fiction",
        rating: 3,
        lastPageRead: 100,
        synopsis: "Five brothers bring each other up in the wake of their parents’ disappearance, and one builds a bridge that will bring them together.",
        cover: "bridge", // Ensure this image is in your Assets.xcassets
        isFavorite: true,
        isLastRead: false
    )
}
