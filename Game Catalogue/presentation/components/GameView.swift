//
//  GameView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct GameView: View {
    let game: Games
    init(game: Games) {
        self.game = game
    }
    var body: some View {
        HStack {
            ImageView(url: game.backgroundImage ?? ERROR_IMAGE)
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(game.name ?? "-")
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                
                Text(game.getGenres())
                    .foregroundColor(.gray)
                    .font(.system(size: 16))
                
                HStack {
                    ImageLabel(
                        image: Image(systemName: "timer"), desc: "\(game.playtime ?? 0) min"
                    )
                    ImageLabel(
                        image: Image(systemName: "calendar"), desc: game.released?.convertToString(format: "dd MMMM yyyy") ?? "-"
                    )
                }
                
            }
        }.frame(minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            alignment: .topLeading
        ).padding(EdgeInsets.init(top: 8, leading: 0, bottom: 8, trailing: 16))
    }
}

struct ImageLabel: View {
    var image: Image
    var desc: String
    var body: some View {
        HStack {
            self.image
                .resizable()
                .frame(width: 14, height: 14)
            Text(desc)
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }.padding(.top, -5)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: getGameData()!)
    }
}
