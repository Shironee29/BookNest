//
//  RegisterPageView.swift
//  Software Engineering
//
//  Created by Stefanie Agahari on 08/06/25.
//

import SwiftUI

struct RegisterPageView: View {
    // Membuat instance ViewModel khusus untuk halaman ini
    @StateObject private var viewModel = RegisterViewModel()
    
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        // Bungkus semua dengan NavigationStack agar NavigationLink berfungsi
        NavigationStack {
            ZStack {
                Color(red: 242/255, green: 242/255, blue: 247/255)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 10) {
                        Spacer(minLength: 20)

                        Image("landing_illustration_full")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.bottom, 5)

                        VStack(spacing: 5) {
                            Text("Siap menata koleksi impianmu?")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.gray)
                            Text("Daftar Sekarang!")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .multilineTextAlignment(.center)

                        Text("Register")
                            .font(.system(size: 32, weight: .bold))
                            .padding(.top, 10)

                        Text("Atur, temukan kembali, dan nikmati bukumu.")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)

                        VStack(spacing: 15) {
                            // Username - dihubungkan ke viewModel.username
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255))
                                    .frame(width: 20, alignment: .center)
                                TextField("Username", text: $viewModel.username)
                                    .autocapitalization(.none)
                            }
                            .padding().background(Color.white).cornerRadius(12).shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                            
                            // Email - dihubungkan ke viewModel.email
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255))
                                    .frame(width: 20, alignment: .center)
                                TextField("Email Address", text: $viewModel.email)
                                    .keyboardType(.emailAddress).autocapitalization(.none)
                            }
                            .padding().background(Color.white).cornerRadius(12).shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)

                            // Password - dihubungkan ke viewModel.password
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255))
                                    .frame(width: 20, alignment: .center)
                                if isPasswordVisible {
                                    TextField("Password", text: $viewModel.password).autocapitalization(.none)
                                } else {
                                    SecureField("Password", text: $viewModel.password).autocapitalization(.none)
                                }
                                Spacer()
                                Button { isPasswordVisible.toggle() } label: {
                                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill").foregroundColor(.gray)
                                }
                            }
                            .padding().background(Color.white).cornerRadius(12).shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                        }
                        
                        // Tampilkan pesan error jika ada
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.top, 5)
                        }
                        
                        // Tombol Register - memanggil viewModel.register()
                        Button(action: {
                            viewModel.register()
                        }) {
                            Text("Register")
                                .fontWeight(.semibold).frame(maxWidth: .infinity).padding(.vertical, 15)
                                .background(Color(red: 251/255, green: 198/255, blue: 60/255))
                                .foregroundColor(.white).cornerRadius(12)
                        }
                        .padding(.top, 20)

                        // Tautan Login - memanggil viewModel.navigateToLogin()
                        HStack(spacing: 4) {
                            Text("Ingin Kembali membaca?")
                                .foregroundColor(.gray)
                            Button(action: {
                                viewModel.navigateToLogin()
                            }) {
                                Text("Login")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 251/255, green: 198/255, blue: 60/255))
                            }
                        }
                        .font(.system(size: 15)).padding(.top, 10)
                        
                        Spacer(minLength: 40)
                        
                        // NavigationLink tersembunyi
                        NavigationLink(destination: LoginPageView(), isActive: $viewModel.shouldNavigateToLogin) { EmptyView() }
                        NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true), isActive: $viewModel.shouldNavigateToHome) { EmptyView() }
                    }
                    .padding(.horizontal, 40)
                }
                .navigationBarHidden(true) // Sembunyikan navigation bar default
            }
        }
    }
}

#Preview {
    RegisterPageView()
}
