//
//  SettingView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

//
//  SettingView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 1) {
                SettingsRow(icon: "person.crop.circle", label: "Account")
                SettingsRow(icon: "bell", label: "Notifications")
                SettingsRow(icon: "lock", label: "Privacy")
                SettingsRow(icon: "lifepreserver", label: "Help Center")
                SettingsRow(icon: "info.circle", label: "General")

                Spacer()
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Settings", displayMode: .inline)
            
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let label: String

    var body: some View {
        NavigationLink(destination: destinationView(for: label)) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(Color.yellow)
                    .frame(width: 24, height: 24)

                Text(label)
                    .foregroundColor(Color.yellow)
                    .font(.system(size: 16, weight: .medium))

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(Color.yellow)
            }
            .padding()
            .background(Color.white)
        }
    }

    @ViewBuilder
    func destinationView(for label: String) -> some View {
        switch label {
        case "Account":
            ProfileView()
        default:
            Text("\(label) Detail")
        }
    }
}

#Preview {
    SettingView()
}



