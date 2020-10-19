//
//  SearchView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 13/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: HomeViewModelImpl = HomeViewModelImpl()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text("Search")
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                        .padding(.trailing, -50)
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Close")
                    }
                    .frame(alignment: .trailing)
                    .padding(.trailing, 12)
                }.padding([.top, .bottom], 8)
                SearchBar(text: self.$viewModel.searchText)
                Spacer()
                if self.viewModel.isLoading {
                    ActivityIndicatorView()
                } else {
                    if self.viewModel.games.count > 0 {
                        List(self.viewModel.games) { (game: Games) in
                            GameView(game: game)
                        }
                        
                    } else if self.viewModel.errorState == .notFound {
                        EmptyStateView()
                    }
                }
                Spacer()
            }
            .onAppear(perform: {
                viewModel.getGames(query: "")
            })
            .navigationBarHidden(true)
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("empty_icon")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                Spacer()
            }
            Text("Tidak Ada Data")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, 8)
            TextField("Search....", text: $text)
                .padding(7)
                .onTapGesture {
                    self.isEditing = true
                }

               if isEditing {
                   Button(action: {
                       self.isEditing = false
                       self.text = ""

                   }) {
                       Text("Cancel")
                   }
                   .padding(.trailing, 10)
                   .transition(.move(edge: .trailing))
                   .animation(.default)
               }
        }
        .foregroundColor(.black)
        .background(
            Rectangle()
                .foregroundColor(.gray).opacity(0.2)
        )
        .cornerRadius(8)
            .padding([.leading, .trailing], 12)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
