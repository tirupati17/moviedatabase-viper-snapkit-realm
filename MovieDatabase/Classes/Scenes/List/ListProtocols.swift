//
//  ListProtocols.swift
//  MovieDatabase
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright (c) 2020 Celerstudio. All rights reserved.
//

import UIKit

enum SortType: Int {
    case vote
    case popularity
    case voteCount
}

enum FilterType: Int {
    case all = 0
    case favorite = 1
}

protocol ListWireframeProtocol: WireframeProtocol {
    func showDetail(_ movieDatabase: ListViewItemProtocol?)
}

protocol ListViewProtocol: ViewProtocol {
    func reloadData()
    func showNoResult(_ localizedDescription: String)
    func removeNoResult()
}

extension ListViewProtocol { //To make it optional
    func showNoResult(_ localizedDescription: String) {}
    func removeNoResult() {}
}

protocol ListPresenterProtocol: PresenterProtocol {
    func sortBy(type: SortType)
    func filterBy(type: FilterType)
    func addToFavorite(id: String, isFavorite: Bool)
    func clearData()

    // MARK: - Table View
    func numberOfSections() -> Int
    func numberOrItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> ListViewItemProtocol?
    func didSelectItem(at indexPath: IndexPath)
}

protocol ListInteractorProtocol: InteractorProtocol {
    func fetchMovieDatabases(bodyParams params: [String: Any]?, result: @escaping (([Result]) -> Void))
    func fetchFavoriteMovieDatabases(result: @escaping (([Result]) -> Void))
    func saveToFavorite(id: String, isFavorite: Bool)
}

protocol ListViewItemProtocol {
    var idString: String { get }
    var dateString: String { get }
    var isAdult: Bool { get }
    var isVideo: Bool { get }
    var imagePath: String { get }
    var titleData: String { get }
    var overviewData: String { get }
    var language: String { get }
    var popularityValue: Double { get }
    var voteAverageValue: Double { get }
    var voteCountValue: Int { get }
    var isFavorite: Bool { get }
}
