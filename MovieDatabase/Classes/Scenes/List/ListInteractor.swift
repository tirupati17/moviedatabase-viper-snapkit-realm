//
//  ListInteractor.swift
//  MovieDatabase
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright (c) 2020 Celerstudio. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

final class ListInteractor {}

// MARK: - Extensions
extension ListInteractor: ListInteractorProtocol {
    func fetchMovieDatabases(bodyParams params: [String: Any]?, result: @escaping (([Result]) -> Void)) {
        AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=\(params?["api_key"] ?? "")&page=\(params?["page"] ?? "1")",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    do {
                        result(self.saveMovieDatabase(try response.data?.toModel(MovieDatabase.self)))
                    } catch let error {
                        Logger.log(error.localizedDescription)
                        result(self.saveMovieDatabase(nil))
                    }
                case .failure(let error):
                    Logger.log(error.localizedDescription)
                    result(self.saveMovieDatabase(nil))
                }
            }
    }
    
    func saveToFavorite(id: String, isFavorite: Bool) {
        guard let idValue = Int(id) else {
            return
        }
        
        do {
            let realm = try Realm()
            let movieDatabases = realm.objects(Result.self).filter("id = %d", idValue)
            
            if let movieDatabase = movieDatabases.first {
                try! realm.write {
                    movieDatabase.favorite = isFavorite
                }
            }
        } catch let error {
            Logger.log(error)
        }
    }

    func fetchFavoriteMovieDatabases(result: @escaping (([Result]) -> Void)) {
        do {
            result(try Array(Realm().objects(Result.self)).filter { $0.favorite == true })
        } catch let error {
            Logger.log(error.localizedDescription)
            result([])
        }
    }
}

extension ListInteractor {
    func saveMovieDatabase(_ movieDatabaseObject: MovieDatabase?) -> [Result] {
        do {
            let realm = try Realm()
            if let movieDatabaseObject = movieDatabaseObject { //Return saved data
                for movieDatabase in movieDatabaseObject.results {
                    //If not available in realm database so add it
                    if realm.objects(Result.self).filter({ $0.id == movieDatabase.id }).count == 0 {
                        let result = Result()
                        result.id = movieDatabase.id
                        result.adult = movieDatabase.adult
                        result.backdropPath = movieDatabase.backdropPath
                        result.genreIDS = movieDatabase.genreIDS
                        result.originalLanguage = movieDatabase.originalLanguage
                        result.originalTitle = movieDatabase.originalTitle
                        result.popularity = movieDatabase.popularity
                        result.posterPath = movieDatabase.posterPath
                        result.releaseDate = movieDatabase.releaseDate
                        result.title = movieDatabase.title
                        result.video = movieDatabase.video
                        result.voteAverage = movieDatabase.voteAverage
                        result.voteCount = movieDatabase.voteCount
                        try realm.write {
                            realm.add(result)
                        }
                    }
                }
            }
            return try Array(Realm().objects(Result.self))
        } catch let error {
            Logger.log(error)
        }
        return []
    }
}
