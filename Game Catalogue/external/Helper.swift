//
//  Helper.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case notFound
    case networkError
}

let BASE_URL = "https://api.rawg.io/api/"
