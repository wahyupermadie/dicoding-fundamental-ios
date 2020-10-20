//
//  FavoriteViewModel.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 20/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation
import CoreData

protocol FavoriteViewModel {
    func getFavorite()
}

class  FavoriteViewModelImpl: ObservableObject, FavoriteViewModel {
    
    @Published var games: [Games] = []
    @Published var isLoading: Bool = true
    private var provider: GameProvider
    init(provider: GameProvider = GameProvider()) {
        self.provider = provider
    }
    func getFavorite() {
        let taskContext = self.provider.newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var resultGames : [Games] = []
                for result in results {
                    let game = Games(id: result.value(forKeyPath: "id") as? Int,
                                     name: result.value(forKeyPath: "name") as? String,
                                     description: nil,
                                     rating: result.value(forKeyPath: "rating") as? Double,
                                     backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
                                     released: result.value(forKeyPath: "released") as? Date,
                                     playtime: result.value(forKeyPath: "playtime") as? Int,
                                     genres: nil,
                                     clip: nil,
                                     movieCount: nil
                               )
                    resultGames.append(game)
                }
                DispatchQueue.main.async {
                    self.games = resultGames
                    self.isLoading = false
                }
            } catch let error as NSError {
                print(error)
                self.isLoading = false
            }
        }
    }
}
