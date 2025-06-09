//
//  LoginPageView.swift
//  Software Engineering
//
//  Created by student on 05/06/25.
//

import SwiftUI

struct LoginPageView: View {
    // Membuat instance ViewModel khusus untuk halaman ini
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        // Bungkus semua dengan NavigationStack agar NavigationLink berfungsi
        NavigationStack {
            ZStack {
                Color(red: 242/255, green: 242/255, blue: 247/255)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        Spacer().frame(height: 30)

                        Image("landing_illustration_full")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding(.bottom, 20)

                        Text("Rindu dengan koleksimu?\nYuk, Masuk!")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Text("Login")
                            .font(.system(size: 34, weight: .bold))
                            .padding(.top, 5)

                        Text("Temukan kembali buku-buku favoritmu.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 25)

                        VStack(spacing: 15) {
                            // Email - dihubungkan ke viewModel.email
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255))
                                    .frame(width: 20)
                                TextField("Email Address", text: $viewModel.email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                            }
                            .padding().background(Color.white).cornerRadius(10)
                            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)

                            // Password - dihubungkan ke viewModel.password
                            // (Kode untuk Password field tetap sama seperti sebelumnya)
                             HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255))
                                    .frame(width: 20)
                                // Anda perlu menambahkan @State private var isPasswordVisible: Bool = false
                                // di dalam view ini untuk logika show/hide password
                                SecureField("Password", text: $viewModel.password)
                                    .autocapitalization(.none)
                                // Tambahkan tombol show/hide di sini jika perlu
                            }
                            .padding().background(Color.white).cornerRadius(10)
                            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                        }
                        .padding(.horizontal, 40)

                        // Tampilkan pesan error jika ada
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.top, 5)
                        }
                        
                        // Tombol Login - memanggil viewModel.login()
                        Button(action: {
                            viewModel.login()
                        }) {
                            Text("Login")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(Color(red: 251/255, green: 198/255, blue: 60/255))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 15)

                        // Tautan Register - memanggil viewModel.navigateToRegister()
                        HStack(spacing: 4) {
                            Text("Baru ingin bergabung?")
                                .foregroundColor(.gray)
                            Button(action: {
                                viewModel.navigateToRegister()
                            }) {
                                Text("Register")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255))
                            }
                        }
                        .font(.system(size: 15))
                        .padding(.top, 10)
                        Spacer()
                        
                        // NavigationLink tersembunyi
                        NavigationLink(destination: RegisterPageView(), isActive: $viewModel.shouldNavigateToRegister) { EmptyView() }
                        NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true), isActive: $viewModel.shouldNavigateToHome) { EmptyView() }
                    }
                }
                .navigationBarHidden(true) // Sembunyikan navigation bar default
            }
        }
    }
}

#Preview {
    LoginPageView()
}
