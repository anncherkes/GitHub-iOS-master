//
//  RepositoriesViewController.swift
//  iOS-GitHub
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

protocol RepositoriesViewControllerProtocol {
    func reload()
}
class RepositoriesViewController: UIViewController, RepositoriesViewControllerProtocol {
    
    var presenter: RepositoriesPresenterProtocol!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView?.tableFooterView = UIView()
        tableView.delegate = self
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My Repositories", style: .plain, target: self, action: #selector(openPersonalRepositories))
    }
    
    @objc private func openPersonalRepositories() {
        presenter.cancel()
        presenter.openPersonalRepositories()
    }
    
    public func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    deinit {
        tableView.delegate = nil
        searchBar.delegate = nil
    }

    private func numberOfRowsInSection(with section: Int) -> Int {
        return presenter.repositories.count
    }
    
    private func heightForCell(with section: Int) -> CGFloat {
        return 165.0
    }
    
    private func createCell(with tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoryTableViewCell
        guard let item = presenter.repositories[safe: indexPath.row] else { return cell }
        cell.setup(with: item)
        return cell
    }

}

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell(with: indexPath.section)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(with: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createCell(with: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = presenter.repositories[safe: indexPath.row] else { return }
        presenter.showRepositoryDetail(with: item)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        presenter!.typeOfScreen = .general
        presenter.cancel()
        
        if searchText.count > 1 {
            presenter.search(with: searchText)
        } else {
            presenter.cancel()
        }
    }
}

