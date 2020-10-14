//
//  Helper.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

enum NetworkError: Error {
    case notFound
    case networkError
}

let baseUrl = "https://api.rawg.io/api/"
let errorImage = "https://cdn-codespeedy.pressidium.com/wp-content/uploads/2019/03/Chrome-Broken-Image-Icon.png"

func getGameData() -> Games? {
    let game: Games? = try? Bundle.main.loadAndDecodeJSON(filename: "game_dummy")
    return game
}

extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let decodedModel = try JSONDecoder().decode(D.self, from: data)
        return decodedModel
    }
}
