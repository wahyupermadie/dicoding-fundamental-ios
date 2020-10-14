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
    @State var showingDetail = false
    
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
                Button(action: {
                    self.showingDetail.toggle()
                }) {
                    Image(systemName: "magnifyingglass")
                }.sheet(isPresented: $showingDetail) {
                    SearchView()
                }
            ).onAppear {
                self.viewModel.getGames(query: "")
                getGameData()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
