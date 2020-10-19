//
//  DetailGameViewModel.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 17/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

protocol DetailGameViewModel {
    func fetchDetailGame(id: Int)
}

class DetailGameViewModelImpl: DetailGameViewModel, ObservableObject {
    @Published var isLoading: Bool = false
    @Published var game: Games?
    @Published var errorState: NetworkError?
    private let service: GameService
    init(service: GameService = GameServiceImpl()) {
        self.service = service
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
                self.isLoading = false
            }
        }
    }
}
