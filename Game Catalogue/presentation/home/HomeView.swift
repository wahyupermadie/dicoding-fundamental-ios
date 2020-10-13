//
//  HomeView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModelImpl = HomeViewModelImpl()
    
    var body: some View {
        NavigationView {
            ZStack {
                if self.viewModel.isLoading {
                    ActivityIndicatorView()
                } else {
                    if self.viewModel.games.count > 0 {
                        List(self.viewModel.games) { (game: Games) in
                            GameView(game: game)
                        }
                    }
                }
            }.navigationBarTitle(
                Text("Video Games")
            ).navigationBarItems(trailing:
                HStack {
                    Image(systemName: "magnifyingglass")
                }
            ).onAppear {
                self.viewModel.getGames(query: "")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
