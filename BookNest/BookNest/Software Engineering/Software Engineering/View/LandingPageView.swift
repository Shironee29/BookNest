//
//  LandingPageView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        ZStack {
            // Warna latar belakang
            Color(red: 242/255, green: 242/255, blue: 247/255) // Abu-abu muda
                .ignoresSafeArea()

            VStack(spacing: 20) { // Mengurangi spacing utama sedikit untuk kontrol lebih baik dengan Spacer
                Spacer() // Mendorong konten sedikit ke bawah dari status bar

                // Logo
                Image("booknest_logo_full") // Ganti dengan nama aset logo Anda
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100) // PERBESAR LOGO
                    .padding(.bottom, 15)

                // Ilustrasi
                Image("landing_illustration_full") // Ganti dengan nama aset ilustrasi Anda
                    .resizable()
                    .scaledToFit()
                    .frame(height: 280) // PERBESAR ILUSTRASI
                    .padding(.bottom, 20)

                // Kontainer untuk teks agar bisa diatur ke tengah bersama-sama
                VStack(spacing: 8) {
                    Text("Susun Dunia Bukumu Bersama BookNest!")
                        .font(.system(size: 22, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20) // Kurangi padding agar teks bisa lebih lebar jika perlu

                    Text("Kelola buku fisik dan digital dalam satu aplikasi. Mari mulai!")
                        .font(.system(size: 15)) // Sedikit perkecil agar proporsional
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30) // Kurangi padding
                }
                .padding(.bottom, 25)


                // Tombol Bergabung Sekarang
                Button(action: {
                    // TODO: Tambahkan aksi navigasi ke halaman Register
                    print("Tombol Bergabung Sekarang! diklik.")
                }) {
                    Text("Bergabung Sekarang!")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(red: 251/255, green: 198/255, blue: 60/255)) // Warna kuning/emas
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40) // Padding untuk tombol


                // Tautan Login
                HStack(spacing: 4) {
                    Text("Ingin Kembali membaca?")
                        .foregroundColor(.gray)
                        .font(.system(size: 14)) // Sedikit perkecil
                    Button(action: {
                        // TODO: Tambahkan aksi navigasi ke halaman Login
                        print("Teks Login diklik.")
                    }) {
                        Text("Login")
                            .fontWeight(.semibold) // Dibuat lebih tebal
                            .font(.system(size: 14)) // Sedikit perkecil
                            .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255))
                    }
                }
                .padding(.top, 5)

                Spacer() // Mendorong elemen di atasnya ke tengah, dan "By" ke bawah

                // Teks "By: Lonely Teenager"
                Text("By : Lonely Teenager")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20) // Jarak dari bawah layar
            }
            .padding(.horizontal, 20) // Padding horizontal keseluruhan untuk VStack utama
        }
    }
}

#Preview {
    LandingPageView()
}
