//
//  MovieDatabase.swift
//  MovieDatabase
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright © 2020 Celerstudio. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - MovieDatabase
struct MovieDatabase: Codable {
    let dates: Dates
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates

struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
class Result: Object, Codable {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String?
    dynamic var genreIDS = List<Int>()
    @objc dynamic var id: Int = 0
    var originalLanguage: OriginalLanguage = .en
    @objc dynamic var originalTitle, overview: String?
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var posterPath, releaseDate, title: String?
    @objc dynamic var video: Bool = false
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var favorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en
    case es
    case ja
    case ru
        
    func getIndex(for value: String) -> Int {
        switch value {
        case "en":
            return 1
        case "es":
            return 2
        case "ja":
            return 3
        default:
            return 4
        }
    }
}

extension Result: ListViewItemProtocol {
    var titleData: String {
        return self.title ?? ""
    }
    
    var overviewData: String {
        return self.overview ?? ""
    }
    
    var popularityValue: Double {
        return self.popularity
    }
    
    var voteAverageValue: Double {
        return self.voteAverage
    }
    
    var voteCountValue: Int {
        return self.voteCount
    }
    
    var dateString: String {
        return self.releaseDate ?? ""
    }
    
    var idString: String {
        return "\(self.id)"
    }
        
    var isAdult: Bool {
        return self.adult
    }
    
    var isVideo: Bool {
        return self.video
    }
    
    var imagePath: String {
        return self.backdropPath ?? ""
    }
    
    var language: String {
        return self.originalLanguage.rawValue
    }

    var isFavorite: Bool {
        return self.favorite
    }

}
