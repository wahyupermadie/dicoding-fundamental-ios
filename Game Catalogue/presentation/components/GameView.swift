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
            ImageView(url: game.backgroundImage)
                .frame(width: 85, height: 85)
                .clipped()
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(game.name)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                Text("Action")
                    .foregroundColor(.gray)
            }
        }.frame(minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            alignment: .topLeading
        ).padding(EdgeInsets.init(top: 8, leading: 0, bottom: 8, trailing: 16))
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: getGameData()!)
    }
}
