//
//  RegisterViewModel.swift
//  Software Engineering
//
//  Created by Stefanie Agahari on 08/06/25.
//

import Foundation
import SwiftData

// ViewModel khusus untuk Register Page
class RegisterViewModel: ObservableObject {

    // Properti untuk menampung input dari View
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    // Properti untuk menampilkan pesan error di View
    @Published var errorMessage: String?
    
    // Properti @Published untuk mengontrol navigasi
    @Published var shouldNavigateToLogin = false
    @Published var shouldNavigateToHome = false

    // Fungsi untuk tombol "Register"
    func register() {
        // Reset pesan error sebelumnya
        errorMessage = nil
        
        // 1. Validasi input sederhana
        if username.isEmpty || email.isEmpty || password.isEmpty {
            errorMessage = "Semua kolom wajib diisi."
            print("Registrasi Gagal: Form tidak lengkap.")
            return
        }
        
        // Contoh validasi email sederhana
        if !email.contains("@") {
            errorMessage = "Format email tidak valid."
            print("Registrasi Gagal: Email tidak valid.")
            return
        }
        
        if password.count < 6 {
            errorMessage = "Password minimal harus 6 karakter."
            print("Registrasi Gagal: Password terlalu pendek.")
            return
        }

        // 2. TODO: Tambahkan logika untuk menyimpan pengguna baru menggunakan SwiftData
        // Misalnya:
        // let newUser = User(username: username, email: email, password: password)
        // context.insert(newUser)
        // try? context.save()

        // 3. Jika registrasi berhasil (simulasi)
        print("RegisterViewModel: Registrasi berhasil untuk user \(username).")
        
        // Ubah state untuk memicu navigasi ke halaman utama
        shouldNavigateToHome = true
    }

    // Fungsi untuk tombol "Login"
    func navigateToLogin() {
        print("RegisterViewModel: Aksi ke halaman Login.")
        
        // Ubah state untuk memicu navigasi
        shouldNavigateToLogin = true
    }
}
