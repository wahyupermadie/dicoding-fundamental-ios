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

let BASE_URL = "https://api.rawg.io/api/"

let DATA_DUMMY = "{\"id\":3498,\"slug\":\"grand-theft-auto-v\",\"name\":\"Grand Theft Auto V\",\"released\":\"2013-09-17\",\"tba\":false,\"background_image\":\"https:\\/\\/media.rawg.io\\/media\\/games\\/84d\\/84da2ac3fdfc6507807a1808595afb12.jpg\",\"rating\":4.48,\"rating_top\":5,\"ratings\":[{\"id\":5,\"title\":\"exceptional\",\"count\":2419,\"percent\":59.01},{\"id\":4,\"title\":\"recommended\",\"count\":1357,\"percent\":33.11},{\"id\":3,\"title\":\"meh\",\"count\":254,\"percent\":6.2},{\"id\":1,\"title\":\"skip\",\"count\":69,\"percent\":1.68}],\"ratings_count\":4057,\"reviews_text_count\":25,\"added\":13025,\"added_by_status\":{\"yet\":306,\"owned\":7952,\"beaten\":3334,\"toplay\":372,\"dropped\":598,\"playing\":463},\"metacritic\":97,\"playtime\":68,\"suggestions_count\":422,\"user_game\":null,\"reviews_count\":4099,\"saturated_color\":\"0f0f0f\",\"dominant_color\":\"0f0f0f\",\"genres\":[{\"id\":4,\"name\":\"Action\",\"slug\":\"action\",\"games_count\":98030}],\"clip\":{\"video\":\"dZubIhK-Z6w\",\"preview\":\"https:\\/\\/media.rawg.io\\/media\\/stories-previews\\/f65\\/f6593df6c8df32c7f4763f9cb112a514.jpg\"}}"

func getGameData() -> Games? {
    do {
        let game = try JSONDecoder().decode(Games.self, from: Data(DATA_DUMMY.utf8))
        print(game)
        return game
    } catch let error {
        print(error)
        return nil
    }
}
