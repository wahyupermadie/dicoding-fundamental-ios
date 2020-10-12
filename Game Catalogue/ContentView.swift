//
//  ContentView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
            }
            FavoriteView()
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("Favorite")
            }
            ProfilView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
