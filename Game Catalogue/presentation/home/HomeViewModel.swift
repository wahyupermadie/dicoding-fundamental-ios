//
//  HomeViewModel.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation
import Combine

protocol HomeViewModel {
    func getGames(query: String?)
}

class HomeViewModelImpl : HomeViewModel, ObservableObject {
    
    private var cancellable: AnyCancellable?
    @Published var isLoading: Bool = false
    @Published var games: [Games] = []
    @Published var searchText = ""
    @Published var errorState: NetworkError?
    private let service: GameService
    
    init(service: GameService = GameServiceImpl()) {
        self.service = service
        cancellable = AnyCancellable(
            $searchText.removeDuplicates()
                .debounce(for: 0.5, scheduler: DispatchQueue.main)
              .sink { searchText in
                self.getGames(query: searchText)
        })
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
                if error == .notFound {
                    self.errorState = .notFound
                    data = []
                } else {
                    self.errorState = .networkError
                }
            }
            
            DispatchQueue.main.async {
                self.games = data
                self.isLoading = false
            }
        }
    }
}
