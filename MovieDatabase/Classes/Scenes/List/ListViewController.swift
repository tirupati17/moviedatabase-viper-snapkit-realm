//
//  ListViewController.swift
//  MovieDatabase
//
//  Created by Tirupati Balan on 21/04/21.
//  Copyright (c) 2020 Celerstudio. All rights reserved.
//

import UIKit
    
final class ListViewController: BaseViewController {

    // MARK: - Private Properties -
    private let topSegment = UISegmentedControl.init(items: ["All", "Favorite"])
    private var listTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    // MARK: - Public properties -
    var presenter: ListPresenterProtocol!
    lazy var noResultView: UILabel = {
        var label = UILabel.init(frame: listTableView.frame)
        label.backgroundColor = UIColor.clear
        label.text = LocalizationKey.Home.NoResultFound.localizedString()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        
        self.refreshControl.beginRefreshing()
        self.presenter.filterBy(type: FilterType.init(rawValue: topSegment.selectedSegmentIndex) ?? .all)
    }
    
    // MARK: - Constraints -
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            listTableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    override func triggerRefreshControl() {
        self.presenter.filterBy(type: FilterType.init(rawValue: topSegment.selectedSegmentIndex) ?? .all)
    }
    
    // MARK: - Methdos -
    func setupView() {        
        view.addSubview(self.listTableView)
        view.setNeedsUpdateConstraints()
        
        topSegment.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        topSegment.selectedSegmentIndex = 0
        navigationItem.titleView = topSegment
    }
    
    @objc func segmentAction(_ sender: UISegmentedControl) {
        self.presenter.clearData()
        self.presenter.filterBy(type: FilterType.init(rawValue: topSegment.selectedSegmentIndex) ?? .all)
    }
    
    @objc func sortItems() {
        self.presenter.sortBy(type: .popularity)
    }
        
    func setupTableView() {
        listTableView.backgroundView = UIView()
        listTableView.tableFooterView = UIView() //To remove extra cell lines
        listTableView.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0) // For full line separator
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.cellIdentifier)
        setupRefreshControl(listTableView)
    }
}

// MARK: - Extensions -
extension ListViewController: ListViewProtocol {
    
    func reloadData() {
        self.refreshControl.endRefreshing()
        self.listTableView.reloadData()
    }
    
    func removeNoResult() {
        self.noResultView.removeFromSuperview()
    }

    func showNoResult(_ localizedDescription: String) {
        self.listTableView.backgroundView?.addSubview(self.noResultView)
        Logger.log(localizedDescription)
    }

}

// MARK: - UITableViewDataSource -
extension ListViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOrItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellIdentifier, for: indexPath) as! ListTableViewCell
        if let object = self.presenter.item(at: indexPath) {
            cell.delegate = self
            cell.configureCell(object)
        }
        
        if indexPath.row == (self.presenter.numberOrItems(in: indexPath.section) - 1) && topSegment.selectedSegmentIndex == 0 {
            self.presenter.filterBy(type: .all)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate -
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.didSelectItem(at: indexPath)
    }
}

extension ListViewController: ListTableViewCellDelegate {
    func favoriteAction(id: String, isFavorite: Bool) {
        self.presenter.addToFavorite(id: id, isFavorite: isFavorite)
    }
}
