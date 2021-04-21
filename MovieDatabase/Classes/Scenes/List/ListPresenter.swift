//
//  ListPresenter.swift
//  MovieDatabase
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright (c) 2020 Celerstudio. All rights reserved.
//

import Foundation

final class ListPresenter {

    // MARK: - Private properties
    private unowned let view: ListViewProtocol
    private let interactor: ListInteractorProtocol
    private let wireframe: ListWireframeProtocol

    private var sortBy: SortType = .vote {
        didSet {
            self.sortMovieDatabases()
        }
    }
    
    private var filterType: FilterType = .all {
        didSet {
            switch filterType {
            case .all:
                self.getMovieDatabases()
            default:
                self.getFavoriteMovieDatabases()
            }
        }
    }

    private var currentPage: Int = 0
    private var movieDatabases: [Result] = []
    
    // MARK: - Lifecycle
    init(view: ListViewProtocol, interactor: ListInteractorProtocol, wireframe: ListWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -
extension ListPresenter: ListPresenterProtocol {
    func addToFavorite(id: String, isFavorite: Bool) {
        self.interactor.saveToFavorite(id: id, isFavorite: isFavorite)
    }

    func sortBy(type: SortType) {
        self.sortBy = type
    }
    
    func filterBy(type: FilterType) {
        self.filterType = type
    }
    
    func clearData() {
        self.movieDatabases.removeAll()
    }
}

// MARK: - Private Methods
private extension ListPresenter {
    func sortMovieDatabases() {
        var sortedMovieDatabases: [Result] = []
        switch self.sortBy {
        case .popularity:
            sortedMovieDatabases = movieDatabases.sorted {
                $0.popularity > $1.popularity
            }
        case .voteCount:
            sortedMovieDatabases = movieDatabases.sorted {
                $0.voteCount > $1.voteCount
            }
        default:
            sortedMovieDatabases = movieDatabases.sorted {
                $0.voteAverage > $1.voteAverage
            }
        }
        self.movieDatabases = sortedMovieDatabases
    }
    
    func getMovieDatabases() {
        self.interactor.fetchMovieDatabases(bodyParams: ["api_key": "34c902e6393dc8d970be5340928602a7", "page": "\(currentPage)"], result: { movieDatabases in
            if movieDatabases.count == 0 {
                self.view.showNoResult(LocalizationKey.Home.NoResultFound.localizedString())
            } else {
                for data in movieDatabases {
                    self.movieDatabases.append(data)
                }
                self.currentPage += 1
            }
            self.view.reloadData()
        })
    }
    
    func getFavoriteMovieDatabases() {
        self.interactor.fetchFavoriteMovieDatabases { movieDatabases in
            self.movieDatabases = movieDatabases
            self.view.reloadData()
        }
    }
}

// MARK: - Table View
extension ListPresenter {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOrItems(in section: Int) -> Int {
        return self.movieDatabases.count
    }
    
    func item(at indexPath: IndexPath) -> ListViewItemProtocol? {
        return self.movieDatabases[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        self.wireframe.showDetail(self.movieDatabases[indexPath.row])
    }
}
