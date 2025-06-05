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
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var selectedGenres: [String] = []
    @State private var pageTotal: String = ""
    @State private var synopsis: String = ""
    @State private var coverImage: UIImage?
    @State private var showGenrePicker = false
    @State private var photoItem: PhotosPickerItem?

    let allGenres = [
        "Fantasy", "Science Fiction", "Mystery", "Romance",
        "Thriller", "Historical", "Horror", "Biography",
        "Adventure", "Drama", "Philosophy", "Self-Help"
    ]

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Header
                HStack {
                    Button(action: {
                        // Back action
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.title2)
                    }

                    Text("Add Book")
                        .font(.title)
                        .bold()
                }

                // MARK: - Cover Image Picker
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

                // MARK: - Book Title
                Group {
                    Text("Book Title").bold()
                    TextField("", text: $title)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(10)
                }

                // MARK: - Author
                Group {
                    Text("Author").bold()
                    TextField("", text: $author)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(10)
                }

                // MARK: - Genre Picker (Multiple Choice)
                Group {
                    Text("Genre (Multiple Choice)").bold()
                    Button(action: {
                        showGenrePicker.toggle()
                    }) {
                        HStack {
                            Text(selectedGenres.isEmpty ? "Select genres" : selectedGenres.joined(separator: ", "))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.yellow)
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

                // MARK: - Page Total
                Group {
                    Text("Page Total").bold()
                    TextField("", text: $pageTotal)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(10)
                }

                // MARK: - Synopsis
                Group {
                    Text("Synopsis").bold()
                    TextEditor(text: $synopsis)
                        .frame(height: 120)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }

                // MARK: - Submit Button
                Button(action: {
                    // Submit logic: Save book to model, API, etc.
                    print("Submitted Book: \(title)")
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
            .padding()
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    AddBookView()
}
