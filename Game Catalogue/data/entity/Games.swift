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
    var results: [Games]?
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
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let ratingsCount, reviewsTextCount, added: Int
    let addedByStatus: AddedByStatus
    let metacritic, playtime, suggestionsCount: Int
    let userGame: JSONNull?
    let reviewsCount: Int
    let saturatedColor, dominantColor: Color
    let platforms: [PlatformElement]?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]?
    let stores: [Store]?
    let clip: Clip?
    let tags: [Genre]?
    let shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores, clip, tags
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int
    let dropped, playing: Int
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
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String?
    let domain: Domain?
    let language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum Domain: String, Codable {
    case appsAppleCOM = "apps.apple.com"
    case epicgamesCOM = "epicgames.com"
    case gogCOM = "gog.com"
    case marketplaceXboxCOM = "marketplace.xbox.com"
    case microsoftCOM = "microsoft.com"
    case nintendoCOM = "nintendo.com"
    case playGoogleCOM = "play.google.com"
    case storePlaystationCOM = "store.playstation.com"
    case storeSteampoweredCOM = "store.steampowered.com"
}

enum Language: String, Codable {
    case eng = "eng"
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: ParentPlatformPlatform
}

// MARK: - ParentPlatformPlatform
struct ParentPlatformPlatform: Codable {
    let id: Int
    let name: Name
    let slug: Slug
}

enum Name: String, Codable {
    case android = "Android"
    case appleMacintosh = "Apple Macintosh"
    case iOS = "iOS"
    case linux = "Linux"
    case nintendo = "Nintendo"
    case pc = "PC"
    case playStation = "PlayStation"
    case xbox = "Xbox"
}

enum Slug: String, Codable {
    case android = "android"
    case ios = "ios"
    case linux = "linux"
    case mac = "mac"
    case nintendo = "nintendo"
    case pc = "pc"
    case playstation = "playstation"
    case xbox = "xbox"
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform
    let releasedAt: String
    let requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int
    let name, slug: String
    let image, yearEnd: JSONNull?
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Requirements
struct Requirements: Codable {
    let minimum: String
    let recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: Title
    let count: Int
    let percent: Double
}

enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}

// MARK: - Store
struct Store: Codable {
    let id: Int
    let store: Genre
    let urlEn: String
    let urlRu: String?

    enum CodingKeys: String, CodingKey {
        case id, store
        case urlEn = "url_en"
        case urlRu = "url_ru"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
