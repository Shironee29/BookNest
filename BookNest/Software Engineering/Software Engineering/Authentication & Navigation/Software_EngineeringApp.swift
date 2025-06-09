//
//  Software_EngineeringApp.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI

@main
struct Software_EngineeringApp: App {
    // Membuat instance ViewModel yang akan hidup selama aplikasi berjalan
    @StateObject private var bookViewModel = BookViewModel()

    var body: some Scene {
        WindowGroup {
            // Memulai aplikasi dari TabBarView dan meneruskan BookViewModel
            // agar bisa diakses oleh HomePageView dan AddBookView.
            TabBarView()
                .environmentObject(bookViewModel)
        }
    }
}
