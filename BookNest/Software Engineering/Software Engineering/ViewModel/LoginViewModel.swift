//
//  LoginViewModel.swift
//  Software Engineering
//
//  Created by Stefanie Agahari on 08/06/25.
//

import Foundation

// ViewModel khusus untuk Login Page
class LoginViewModel: ObservableObject {

    // Properti untuk menampung input dari View
    @Published var email = ""
    @Published var password = ""
    
    // Properti untuk menampilkan pesan error di View
    @Published var errorMessage: String?
    
    // Properti @Published untuk mengontrol navigasi
    @Published var shouldNavigateToRegister = false
    @Published var shouldNavigateToHome = false

    // Fungsi untuk tombol "Login"
    func login() {
        // Reset pesan error sebelumnya
        errorMessage = nil
        
        // 1. Validasi input sederhana
        if email.isEmpty || password.isEmpty {
            errorMessage = "Email dan Password tidak boleh kosong."
            print("Login Gagal: Form tidak lengkap.")
            return
        }

        // 2. TODO: Tambahkan logika otentikasi dengan SwiftData atau backend Anda di sini
        // Misalnya, cari pengguna di database dengan email dan verifikasi password.

        // 3. Jika otentikasi berhasil (simulasi)
        print("LoginViewModel: Login berhasil untuk user \(email).")
        
        // Ubah state untuk memicu navigasi ke halaman utama
        shouldNavigateToHome = true
    }

    // Fungsi untuk tombol "Register"
    func navigateToRegister() {
        print("LoginViewModel: Aksi ke halaman Register.")
        
        // Ubah state untuk memicu navigasi
        shouldNavigateToRegister = true
    }
}
