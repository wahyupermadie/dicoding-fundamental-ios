//
//  GameService.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

typealias gameResultCompletion = (Result<[Games], NetworkError>) -> Void
typealias gameDetailResultCompletion = (Result<Games, NetworkError>) -> Void

protocol GameService {
    func getGames(query: String?, completion: @escaping gameResultCompletion)
    func getDetailGame(gameId: Int, completion: @escaping gameDetailResultCompletion)
}

class GameServiceImpl: GameService {
    
    private let urlSession = URLSession.shared
    
    func getGames(query: String?, completion: @escaping gameResultCompletion) {
        guard let url = makeUrl(endpoint: "games", param: "search", queryParam: query ?? "") else {
            return
        }
        
        self.urlSession.dataTask(with: url){ (data, response, error) in
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(GameResponse.self, from: data!)
                
                if let games = result.results {
                    completion(.success(games))
                }else{
                    completion(.failure(.notFound))
                }
            } catch let error {
                print(error)
                completion(.failure(.networkError))
            }
        }.resume()
    }
    
    func getDetailGame(gameId: Int, completion: @escaping gameDetailResultCompletion){
        guard let url = URL(string: "\(BASE_URL)games/\(gameId)") else {
            return
        }
        
        self.urlSession.dataTask(with: url){ (data,response, error) in
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Games.self, from: data!)
                completion(.success(result))
            }catch let error {
                print(error)
                completion(.failure(.networkError))
            }
        }
    }
    
    private func makeUrl(endpoint: String, param: String?, queryParam: String = "") -> URL? {
        guard let url = URL(string: "\(BASE_URL)\(endpoint)") else {
            return nil
        }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        if param != nil {
            let queryItems = [URLQueryItem(name: param!, value: queryParam)]
            urlComponents.queryItems = queryItems
        }
        
        guard let finalURL = urlComponents.url else {
            return nil
        }
        
        return finalURL
    }
}
