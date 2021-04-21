//
//  ListDetailProtocols.swift
//  MovieDatabase
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright (c) 2020 Celerstudio. All rights reserved.
//

import UIKit

protocol ListDetailWireframeProtocol: WireframeProtocol {
}

protocol ListDetailViewProtocol: ViewProtocol {
    func updateView(_ movieDatabase: ListViewItemProtocol?)
}

protocol ListDetailPresenterProtocol: PresenterProtocol {
}

protocol ListDetailInteractorProtocol: InteractorProtocol {
}
