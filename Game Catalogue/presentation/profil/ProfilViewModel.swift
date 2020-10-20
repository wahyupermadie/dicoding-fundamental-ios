//
//  ProfilViewModel.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 20/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

class ProfilViewModel: ObservableObject {
    @Published var userName = ProfilDataModel.userName
    @Published var userGithub = ProfilDataModel.userGithub
}
