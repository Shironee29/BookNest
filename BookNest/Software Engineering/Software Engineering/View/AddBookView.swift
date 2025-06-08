//
//  AddPageView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI
import PhotosUI

struct AddBookView: View {
    // MARK: - Properties
    
    // Menerima BookViewModel dari environment untuk berkomunikasi
    @EnvironmentObject var bookViewModel: BookViewModel
    
    // Environment untuk menutup tampilan (sheet) ini
    @Environment(\.dismiss) var dismiss
    
    // State lokal untuk menampung data dari form
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var selectedGenres: [String] = []
    @State private var pageTotal: String = ""
    @State private var synopsis: String = ""
    @State private var coverImage: UIImage?
    @State private var showGenrePicker = false
    @State private var photoItem: PhotosPickerItem?
    
    // Properti untuk menampilkan pesan error jika validasi gagal
    @State private var showingAlert = false

    let allGenres = [
        "Fantasy", "Science Fiction", "Mystery", "Romance",
        "Thriller", "Historical", "Horror", "Biography",
        "Adventure", "Drama", "Philosophy", "Self-Help"
    ]

    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Memanggil fungsi-fungsi pembantu untuk setiap bagian UI
                    coverImagePickerSection
                    
                    bookTitleSection
                    
                    authorSection
                    
                    genrePickerSection
                    
                    pageTotalSection
                    
                    synopsisSection
                    
                    submitButton
                }
                .padding()
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Form Incomplete", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please fill in both the Book Title and Author.")
            }
        }
    }

    // MARK: - Sub-views (Ekspresi yang Dipecah)
    
    // Bagian untuk Cover Image Picker
    private var coverImagePickerSection: some View {
        PhotosPicker(selection: $photoItem, matching: .images) {
            ZStack {
                if let image = coverImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(12)
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.yellow)
                        .frame(height: 200)
                        .overlay(
                            Text("Upload Book Cover")
                                .foregroundColor(.white)
                                .bold()
                        )
                }
            }
        }
        .onChange(of: photoItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    coverImage = uiImage
                }
            }
        }
    }
    
    // Bagian untuk Judul Buku
    private var bookTitleSection: some View {
        Group {
            Text("Book Title").bold()
            TextField("Enter book title", text: $title)
                .padding()
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(10)
        }
    }
    
    // Bagian untuk Penulis
    private var authorSection: some View {
        Group {
            Text("Author").bold()
            TextField("Enter author's name", text: $author)
                .padding()
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(10)
        }
    }

    // Bagian untuk Pemilih Genre
    private var genrePickerSection: some View {
        Group {
            Text("Genre (Multiple Choice)").bold()
            Button(action: {
                withAnimation {
                    showGenrePicker.toggle()
                }
            }) {
                HStack {
                    Text(selectedGenres.isEmpty ? "Select genres" : selectedGenres.joined(separator: ", "))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(showGenrePicker ? 180 : 0))
                }
                .padding()
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(10)
            }

            if showGenrePicker {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(allGenres, id: \.self) { genre in
                        Button(action: {
                            if selectedGenres.contains(genre) {
                                selectedGenres.removeAll { $0 == genre }
                            } else {
                                selectedGenres.append(genre)
                            }
                        }) {
                            HStack {
                                Image(systemName: selectedGenres.contains(genre) ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.yellow)
                                Text(genre)
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    // Bagian untuk Total Halaman
    private var pageTotalSection: some View {
        Group {
            Text("Page Total").bold()
            TextField("Enter total pages", text: $pageTotal)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(10)
        }
    }
    
    // Bagian untuk Sinopsis
    private var synopsisSection: some View {
        Group {
            Text("Synopsis").bold()
            TextEditor(text: $synopsis)
                .frame(height: 120)
                .padding(8)
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.black)
        }
    }
    
    // Bagian untuk Tombol Submit
    private var submitButton: some View {
        Button(action: {
                if !title.isEmpty && !author.isEmpty {
                    // Panggil fungsi addBook dari ViewModel dengan menyertakan coverImage
                    bookViewModel.addBook(
                        title: title,
                        author: author,
                        genre: selectedGenres.joined(separator: ", "),
                        pageTotal: pageTotal,
                        synopsis: synopsis,
                        coverImage: coverImage // <-- Teruskan UIImage yang dipilih pengguna
                    )
                    dismiss()
                } else {
                    showingAlert = true
                }
        }) {
            Text("SUBMIT")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
                .foregroundColor(.white)
                .bold()
                .cornerRadius(10)
        }
    }
}


#Preview {
    AddBookView()
        .environmentObject(BookViewModel())
}
