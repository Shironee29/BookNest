//
//  LoginPageView.swift
//  Software Engineering
//
//  Created by student on 05/06/25.
//

import SwiftUI

struct LoginPageView: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false // Untuk toggle visibilitas password

    // Nanti Anda bisa tambahkan @EnvironmentObject atau @ObservedObject
    // untuk ViewModel yang menghandle logika login dan navigasi.
    // Misalnya:
    // @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            // Warna latar belakang
            Color(red: 242/255, green: 242/255, blue: 247/255) // Abu-abu muda
                .ignoresSafeArea()

            ScrollView { // Agar konten bisa di-scroll jika keyboard muncul atau konten panjang
                VStack(spacing: 20) {
                    Spacer()
                        .frame(height: 30) // Memberi ruang di atas

                    // Ilustrasi (tampaknya sama dengan landing page)
                    Image("landing_illustration_full") // Ganti dengan nama aset ilustrasi Anda jika berbeda
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200) // Sesuaikan tinggi ilustrasi
                        .padding(.bottom, 20)

                    // Teks Header
                    Text("Rindu dengan koleksimu?\nYuk, Masuk!")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    // Judul "Login"
                    Text("Login")
                        .font(.system(size: 34, weight: .bold))
                        .padding(.top, 5)

                    // Sub-judul
                    Text("Temukan kembali buku-buku favoritmu.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50)
                        .padding(.bottom, 25)

                    // Form Input
                    VStack(spacing: 15) {
                        // Email Address Field
                        HStack {
                            Image(systemName: "envelope.fill") // Ikon email
                                .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255)) // Warna kuning ikon
                                .frame(width: 20)
                            TextField("Email Address", text: $emailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)

                        // Password Field
                        HStack {
                            Image(systemName: "lock.fill") // Ikon gembok
                                .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255)) // Warna kuning ikon
                                .frame(width: 20)
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("Password", text: $password)
                                    .autocapitalization(.none)
                            }
                            Spacer()
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                    }
                    .padding(.horizontal, 30)

                    Spacer() // Mendorong tombol ke bawah

                    // Tombol Login (Akan dibuat di langkah berikutnya jika ada,
                    // atau tombol di bawah ini adalah tombol utama)

                    // Tautan Register
                    Button(action: {
                        // TODO: Tambahkan aksi navigasi ke halaman Register
                        print("Tautan Register diklik.")
                        // Contoh: authViewModel.navigateToRegister()
                    }) {
                        HStack(spacing: 4) {
                            Text("Baru ingin bergabung?")
                                .foregroundColor(.gray)
                            Text("Register")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255)) // Warna kuning
                        }
                        .font(.system(size: 15))
                        .padding() // Membuat area klik lebih besar
                        .frame(maxWidth: .infinity) // Membuat tombol selebar mungkin
                        .background(Color(UIColor.systemGray5)) // Warna latar belakang seperti di screenshot
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30) // Jarak dari bawah layar
                }
                .padding(.horizontal, 20) // Padding horizontal keseluruhan
            }
        }
        // .navigationBarHidden(true) // Jika halaman ini tidak berada dalam NavigationView atau ingin menyembunyikan barnya
    }
}

#Preview {
    LoginPageView()
    // Jika menggunakan EnvironmentObject, tambahkan di sini untuk preview:
    // .environmentObject(AuthViewModel())
}
