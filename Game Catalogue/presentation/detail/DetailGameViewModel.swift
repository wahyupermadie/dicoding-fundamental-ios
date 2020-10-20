//
//  DetailGameViewModel.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 17/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation
import CoreData

protocol DetailGameViewModel {
    func fetchDetailGame(id: Int)
}

class DetailGameViewModelImpl: DetailGameViewModel, ObservableObject {
    @Published var isLoading: Bool = false
    @Published var isFavorite: Bool = false
    @Published var game: Games?
    @Published var errorState: NetworkError?
    @Published var isShowAddFavDialog: Bool = false
    @Published var isAddFavoriteMessage: String = ""
    @Published var isAddFavoriteTitle: String = ""
    
    private let service: GameService
    private let gameProvider: GameProvider
    init(service: GameService = GameServiceImpl(), provider: GameProvider = GameProvider()) {
        self.service = service
        self.gameProvider = provider
    }
    func fetchDetailGame(id: Int) {
        self.isLoading = true
        service.getDetailGame(gameId: id) { [weak self] (data) in
            guard let self = self else { return }
            var game : Games? = nil
            switch data {
            case .success(let result):
                game = result
                
            case .failure(let error):
                self.errorState = error
            }
            DispatchQueue.main.async {
                self.game = game
                self.getFavorite(game: game)
                self.isLoading = false
            }
        }
    }
    
    func getFavorite(game: Games?) {
        guard let game = game else { return }
        let task = gameProvider.newTaskContext()
        task.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(String(describing: game.id!))")
            do {
                if (try task.fetch(fetchRequest).first) != nil {
                    DispatchQueue.main.async {
                        self.isFavorite = true
                    }
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func deleteFavorite(gameId: Int) {
        let task = gameProvider.newTaskContext()
        task.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
            fetchRequest.predicate = NSPredicate(format: "id == \(gameId)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? task.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                print("Sukses hapus favorite")
                DispatchQueue.main.async {
                    self.isFavorite = false
                }
            }
        }
    }
    
    func addFavorite(games: Games?) {
        guard let games = games else { return }
        let task = gameProvider.newTaskContext()
        task.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Game", in: task) {
                let game = NSManagedObject(entity: entity, insertInto: task)
                game.setValue(games.id, forKeyPath: "id")
                game.setValue(games.backgroundImage, forKeyPath: "backgroundImage")
                game.setValue(games.name, forKeyPath: "name")
                game.setValue(games.playtime, forKeyPath: "playtime")
                game.setValue(games.rating, forKeyPath: "rating")
                game.setValue(games.released, forKeyPath: "released")
                
                do {
                    try task.save()
                    DispatchQueue.main.async {
                        self.isFavorite = true
                        self.isShowAddFavDialog = true
                        self.isAddFavoriteTitle = "Sukses !!!"
                        self.isAddFavoriteMessage = "Selamat kamu berhasil menambahkan \(games.name!)"
                    }
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                    DispatchQueue.main.async {
                        self.isShowAddFavDialog = true
                        self.isAddFavoriteTitle = "Gagal !!!"
                        self.isAddFavoriteMessage = "Could not save. \(error), \(error.userInfo)"
                    }
                }
            }
        }
    }
}
