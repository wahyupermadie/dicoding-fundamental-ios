//
//  HomeViewModel.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

protocol HomeViewModel {
    func getGames(query: String?)
}

class HomeViewModelImpl : HomeViewModel, ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var games: [Games] = []
    
    private let service: GameService
    
    init(service: GameService = GameServiceImpl()) {
        self.service = service
    }
    
    func getGames(query: String?) {
        self.isLoading = true
        service.getGames(query: query) { [weak self] (result) in
            guard let self = self else {return}
            
            var data: [Games] = []
            switch result {
            case .success(let response):
                data = response
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.games = data
                self.isLoading = false
            }
        }
    }
}
