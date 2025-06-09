//
//  ProfileView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible = false

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                
            }
            .padding(.horizontal)

            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)

            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.purple)

            Button("Edit Profile") {}
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(Color("ButtonYellow"))
                .foregroundColor(.white)
                .cornerRadius(20)

            VStack(alignment: .leading, spacing: 12) {
                ProfileField(label: "Username", text: $username)
                ProfileField(label: "Email Address", text: $email)
                SecureFieldView(password: $password, isVisible: $isPasswordVisible)
            }
            .padding(.horizontal)

            Spacer()

            Button("Logout") {
                // Logout logic
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("ButtonYellow"))
            .foregroundColor(.white)
            .cornerRadius(25)
            .padding(.horizontal)
        }
        .padding(.top)
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}

struct ProfileField: View {
    var label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            TextField(label, text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.1), radius: 3, x: 0, y: 2)
        }
    }
}

struct SecureFieldView: View {
    @Binding var password: String
    @Binding var isVisible: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Password")
                .font(.caption)
                .foregroundColor(.gray)
            HStack {
                if isVisible {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }
                Button(action: {
                    isVisible.toggle()
                }) {
                    Image(systemName: isVisible ? "eye" : "eye.slash")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.1), radius: 3, x: 0, y: 2)
        }
    }
}


#Preview {
    ProfileView()
}
