//
//  TabBarView.swift
//  Software Engineering
//
//  Created by student on 03/06/25.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedIndex = 1

    var body: some View {
        TabView(selection: $selectedIndex) {
            FavoriteView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Favorite")
                }.tag(0)

            HomePageView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(1)

            SettingView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }.tag(2)
        }
        .accentColor(.blue)
    }
}


#Preview {
    TabBarView()
}
