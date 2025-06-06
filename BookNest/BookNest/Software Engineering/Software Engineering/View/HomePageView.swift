import SwiftUI

struct HomePageView: View {
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
                    NavigationLink("", destination: AddBookView(), isActive: $isShowingAddBookView)
                        .opacity(0)
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
                        BookSection(title: "Last Read", books: dummyBooks.filter { $0.isLastRead })
                        BookSection(title: "Favorites", books: dummyBooks.filter { $0.isFavorite })
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }

    // MARK: - Book Section
    func BookSection(title: String, books: [Book]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(books) { book in
                        BookItem(book: book)
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }

    // MARK: - Book Item
    @ViewBuilder
    func BookItem(book: Book) -> some View {
        NavigationLink(destination: book.title == "Bridge of Clay" ? AnyView(BookDetailView(book: book)) : AnyView(Text("No Detail View"))) {
            VStack(alignment: .leading, spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    Image(book.cover)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 160)
                        .clipped()
                        .cornerRadius(12)

                    if book.isFavorite || book.isLastRead {
                        Image(systemName: book.isFavorite ? "bookmark.fill" : "clock.fill")
                            .foregroundColor(.orange)
                            .padding(6)
                    }
                }

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
}

