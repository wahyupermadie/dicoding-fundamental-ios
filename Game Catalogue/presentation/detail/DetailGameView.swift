//
//  DetailGameView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 14/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct DetailGameView: View {
    var gameId: Int = 0
    @ObservedObject var viewModel: DetailGameViewModelImpl = DetailGameViewModelImpl()
    
    init(gameId: Int) {
        self.gameId = gameId
    }
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ActivityIndicatorView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ImageView(url: viewModel.game?.backgroundImage ?? "")
                            .frame(maxWidth: .infinity, maxHeight: 500)
                            .scaledToFit()
                        Text(viewModel.game?.name ?? "")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .padding([.leading, .trailing], 8)
                        Divider().background(Color.black)
                        HStack(alignment: .center, spacing: 16) {
                            Spacer()
                            VStack {
                                Text("Rating")
                                Text("\(String(format: "%.1f", viewModel.game?.rating ?? 0.0))")
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            Divider().frame(height: 25).background(Color.black)
                            VStack {
                                Text("Duration")
                                Text("\(viewModel.game?.playtime ?? 0) min")
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            Divider().frame(height: 25).background(Color.black)
                            VStack {
                                Text("Movies")
                                Text("\(viewModel.game?.moviesCount ?? 0)")
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            Spacer()
                        }
                        Divider().background(Color.black)
                        Text(viewModel.game?.description ?? "").font(.system(size: 14))
                            .padding([.leading, .trailing], 8)
                        Divider().background(Color.black)
                        if viewModel.game?.clip != nil {
                            Text("Short Clip")
                                .fontWeight(.bold)
                                .padding(.leading, 8)
                                .font(.system(size: 18))
                            VideoView(videoURL: URL(string: viewModel.game?.clip?.clip ?? "")!, previewLength: 60)
                                .cornerRadius(15)
                                .frame(width: nil, height: 200, alignment: .center)
                                .shadow(color: Color.black.opacity(0.5), radius: 30, x: 0, y: 2)
                                .padding(.horizontal, 8)
                                .padding(.top, 4)
                        }
                        Spacer()
                    }
                }
            }
        }.onAppear(perform: {
            viewModel.fetchDetailGame(id: self.gameId)
        }).navigationBarTitle(
            Text("Detail Game"),
            displayMode: .inline
        ).navigationBarItems(trailing:
            Button(action: {
                if self.viewModel.isFavorite {
                    self.viewModel.deleteFavorite(gameId: self.gameId)
                } else {
                    self.viewModel.addFavorite(games: self.viewModel.game)
                }
            }) {
                if self.viewModel.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                } else {
                    Image(systemName: "heart")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
            }
        ).alert(isPresented: self.$viewModel.isShowAddFavDialog) {
            Alert(title: Text(self.viewModel.isAddFavoriteTitle), message: Text(self.viewModel.isAddFavoriteMessage))
        }
    }
}

struct DetailGameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailGameView(gameId: 12)
        }
    }
}
