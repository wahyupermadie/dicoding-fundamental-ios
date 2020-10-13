//
//  ViewExt.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 13/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation
import SwiftUI

extension Games {
    func getGenres() -> String {
        guard let genres = self.genres else { return ""}
        return genres.map{ $0.name }.joined(separator: ", ")
    }
}
