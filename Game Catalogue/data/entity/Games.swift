//
//  Games.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 12/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

// MARK: - Games
struct GameResponse: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [Games] = []
}

// MARK: - Filters
struct Filters: Codable {
    let years: [FiltersYear]
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    let from, to: Int
    let filter: String
    let decade: Int
    let years: [YearYear]
    let nofollow: Bool
    let count: Int
}

// MARK: - YearYear
struct YearYear: Codable {
    let year, count: Int
    let nofollow: Bool
}

// MARK: - Result
struct Games: Codable, Identifiable {
    let id: Int?
    let name: String?
    let released: Date?
    let backgroundImage: String?
    let rating: Double?
    let playtime: Int?
    let genres: [Genre]?
    let clip: Clip?

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating, playtime, genres, clip
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        released = try? container.decode(String.self, forKey: .released).convertToDate()
        backgroundImage = try? container.decode(String.self, forKey: .backgroundImage)
        rating = try? container.decode(Double.self, forKey: .rating)
        playtime = try? container.decode(Int.self, forKey: .playtime)
        genres = try? container.decode([Genre].self, forKey: .genres)
        clip = try? container.decode(Clip.self, forKey: .clip)
    }
}


// MARK: - Clip
struct Clip: Codable {
    let clip: String?
    let clips: Clips?
    let video: String
    let preview: String
}

// MARK: - Clips
struct Clips: Codable {
    let the320, the640, full: String

    enum CodingKeys: String, CodingKey {
        case the320 = "320"
        case the640 = "640"
        case full
    }
}

enum Color: String, Codable {
    case the0F0F0F = "0f0f0f"
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case language
    }
}

enum Language: String, Codable {
    case eng = "eng"
}
