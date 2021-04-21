//
//  ListDetailWireframe.swift
//  MovieDatabase
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright (c) 2020 Celerstudio. All rights reserved.
//

import UIKit

final class ListDetailWireframe: BaseWireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init(_ movieDatabase: ListViewItemProtocol?) {
        let moduleViewController = ListDetailViewController()
        super.init(viewController: moduleViewController)

        let interactor = ListDetailInteractor()
        let presenter = ListDetailPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        presenter.movieDatabase = movieDatabase
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension ListDetailWireframe: ListDetailWireframeProtocol {
}
