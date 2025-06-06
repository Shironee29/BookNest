import SwiftUI

struct EditBookView: View {
    @ObservedObject var book: Book // The original book object being edited
    @Environment(\.dismiss) var dismiss // To dismiss the sheet

    // State variables to hold the *editable copies* of the book's properties
    @State private var editedTitle: String
    @State private var editedAuthor: String
    @State private var editedGenre: String
    @State private var editedRating: Int
    @State private var editedLastPageRead: Int
    @State private var editedSynopsis: String
    // @State private var editedCover: String // You could make cover editable via text field too, if desired
    @State private var editedIsFavorite: Bool
    @State private var editedIsLastRead: Bool

    // Initializer to set up the @State variables from the incoming book object
    init(book: Book) {
        self.book = book // Assign the ObservedObject

        // Initialize @State properties from the original book's current values
        _editedTitle = State(initialValue: book.title)
        _editedAuthor = State(initialValue: book.author)
        _editedGenre = State(initialValue: book.genre)
        _editedRating = State(initialValue: book.rating)
        _editedLastPageRead = State(initialValue: book.lastPageRead)
        _editedSynopsis = State(initialValue: book.synopsis)
        // _editedCover = State(initialValue: book.cover) // If cover was editable
        _editedIsFavorite = State(initialValue: book.isFavorite)
        _editedIsLastRead = State(initialValue: book.isLastRead)
    }

    var body: some View {
        NavigationView { // Embed in NavigationView for its own navigation bar
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    // Book Cover Image (Display only in edit view for now)
                    if !book.cover.isEmpty {
                        Image(book.cover)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 225)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                            .padding(.bottom, 10)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }

                    // Title (Editable)
                    HStack {
                        TextField("Title", text: $editedTitle)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .textFieldStyle(.roundedBorder)
                        Spacer()
                        // Favorite toggle directly on the book (for immediate update if desired)
                        Image(systemName: editedIsFavorite ? "heart.fill" : "heart")
                            .foregroundColor(editedIsFavorite ? .red : .gray)
                            .font(.title2)
                            .onTapGesture {
                                editedIsFavorite.toggle()
                            }
                    }
                    .padding(.horizontal)

                    // Author (Editable)
                    TextField("Author", text: $editedAuthor)
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)

                    // Genre (Editable)
                    HStack {
                        Text("Genre :")
                            .font(.headline)
                        TextField("Genre", text: $editedGenre)
                            .font(.body)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding(.horizontal)

                    // Rating (Stepper)
                    HStack {
                        Text("Rating :")
                            .font(.headline)
                        Stepper(value: $editedRating, in: 0...5) {
                            HStack(spacing: 2) {
                                ForEach(1...5, id: \.self) { star in
                                    Image(systemName: star <= editedRating ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .padding(.horizontal)

                    // Last Read (Stepper)
                    HStack {
                        Text("Last Read :")
                            .font(.headline)
                        Stepper(value: $editedLastPageRead, in: 0...2000) {
                            Text("Page \(editedLastPageRead)")
                        }
                        .padding(.vertical, 5)
                    }
                    .padding(.horizontal)

                    // Synopsis (Multiline TextField)
                    VStack(alignment: .leading) {
                        Text("Synopsis :")
                            .font(.headline)
                            .padding(.bottom, 2)
                        TextField("Synopsis", text: $editedSynopsis, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(4...10) // Allow multiple lines for synopsis
                            .frame(minHeight: 100) // Give it a minimum height
                    }
                    .padding(.horizontal)

                    // Toggle for isLastRead
                    Toggle("Mark as Last Read", isOn: $editedIsLastRead)
                        .padding(.horizontal)
                        .font(.headline)
                }
                .padding(.top, 20)
            }
            .navigationTitle("Edit Book Details") // Title for the edit sheet
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss() // Dismiss without saving changes
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Commit changes back to the original book object
                        book.title = editedTitle
                        book.author = editedAuthor
                        book.genre = editedGenre
                        book.rating = editedRating
                        book.lastPageRead = editedLastPageRead
                        book.synopsis = editedSynopsis
                        // book.cover = editedCover // If cover was editable
                        book.isFavorite = editedIsFavorite
                        book.isLastRead = editedIsLastRead

                        dismiss() // Dismiss the sheet after saving
                    }
                }
            }
        }
    }
}

// Preview for EditBookDetailView
struct EditBookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EditBookView(book: Book.example)
    }
}
