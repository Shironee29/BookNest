//
//  LandingPageView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI

struct LandingPageView: View {
    // Membuat instance dari ViewModel khusus untuk halaman ini
    @StateObject private var viewModel = LandingViewModel()

    var body: some View {
        // Bungkus semua dengan NavigationStack agar NavigationLink berfungsi
        NavigationStack {
            ZStack {
                // Warna latar belakang
                Color(red: 242/255, green: 242/255, blue: 247/255)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer()

                    // Logo
                    Image("booknest_logo_full")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)

                    // Ilustrasi
                    Image("landing_illustration_full")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .padding(.bottom, 10)

                    VStack(spacing: 8) {
                        Text("Susun Dunia Bukumu Bersama BookNest!")
                            .font(.system(size: 22, weight: .bold))
                            .multilineTextAlignment(.center)

                        Text("Kelola buku fisik dan digital dalam satu aplikasi. Mari mulai!")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 10)
                    }
                    .padding(.horizontal, 30)

                    // Tombol Bergabung Sekarang
                    Button(action: {
                        // Panggil fungsi dari LandingViewModel
                        viewModel.onRegisterTapped()
                    }) {
                        Text("Bergabung Sekarang!")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color(red: 251/255, green: 198/255, blue: 60/255))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 25)

                    // Tautan Login
                    HStack(spacing: 4) {
                        Text("Ingin Kembali membaca?")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                        Button(action: {
                            // Panggil fungsi dari LandingViewModel
                            viewModel.onLoginTapped()
                        }) {
                            Text("Login")
                                .fontWeight(.semibold)
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255))
                        }
                    }
                    .padding(.top, 5)
                    
                    Spacer()

                    Text("By : Lonely Teenager")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)

                // LOGIKA NAVIGASI DENGAN NAVIGATIONLINK
                // NavigationLink ini "tidak terlihat" dan akan aktif berdasarkan
                // perubahan state di ViewModel.
                
                NavigationLink(
                    destination: RegisterPageView(),
                    isActive: $viewModel.shouldNavigateToRegister,
                    label: { EmptyView() }
                )
                
                NavigationLink(
                    destination: LoginPageView(),
                    isActive: $viewModel.shouldNavigateToLogin,
                    label: { EmptyView() }
                )
            }
        }
    }
}

#Preview {
    LandingPageView()
}
