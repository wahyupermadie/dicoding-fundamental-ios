//
//  FavoriteView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: FavoriteViewModelImpl = FavoriteViewModelImpl()
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
                Text("Games Favorite")
            ).onAppear {
                self.viewModel.getFavorite()
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
