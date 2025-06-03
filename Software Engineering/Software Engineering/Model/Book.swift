//
//  Book.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let cover: String
    let isFavorite: Bool
    let isLastRead: Bool
}
