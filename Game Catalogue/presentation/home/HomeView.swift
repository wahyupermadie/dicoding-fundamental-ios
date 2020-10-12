//
//  HomeView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Text("wkwkkw")
            }.navigationBarTitle(
                Text("Video Games")
            ).navigationBarItems(trailing:
                HStack {
                    Image(systemName: "magnifyingglass")
                }
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
