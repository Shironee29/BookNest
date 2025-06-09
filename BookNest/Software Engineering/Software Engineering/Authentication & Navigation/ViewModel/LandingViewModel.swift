//
//  LandingViewModel.swift
//  Software Engineering
//
//  Created by Stefanie Agahari on 08/06/25.
//

import Foundation

// ViewModel khusus untuk Landing Page
class LandingViewModel: ObservableObject {
    
    // Properti @Published untuk mengontrol navigasi di dalam LandingPageView
    @Published var shouldNavigateToRegister = false
    @Published var shouldNavigateToLogin = false
    
    // Fungsi untuk tombol "Bergabung Sekarang"
    func onRegisterTapped() {
        print("LandingViewModel: Aksi ke halaman Register.")
        shouldNavigateToRegister = true
    }
    
    // Fungsi untuk teks "Login"
    func onLoginTapped() {
        print("LandingViewModel: Aksi ke halaman Login.")
        shouldNavigateToLogin = true
    }
}
