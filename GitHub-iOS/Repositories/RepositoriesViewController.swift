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
    
    private func getNumberOfSections() -> Int {
        switch presenter!.typeOfScreen {
        case .general:
            return 2
        case .personal:
            return 1
        }
    }
    
    private func numberOfRowsInSection(with section: Int) -> Int {
        
        if self.getNumberOfSections() > 1 {
            switch section {
            case 0:
                return 1
            case 1:
                return presenter.repositories.count
            default:
                return 1
            }
        } else {
            return presenter.repositories.count
        }
    }
    
    private func heightForCell(with section: Int) -> CGFloat {
         if self.getNumberOfSections() > 1 {
            switch section {
            case 0:
                return 80.0
            case 1:
                return 165.0
            default:
                return 0.0
            }
         } else {
            return 165.0
        }
    }
    
    private func createCell(with tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch presenter!.typeOfScreen {
        case .general:
            return createCellForGeneral(with: tableView, indexPath: indexPath)
        case .personal:
            return createCellForPersonal(with: tableView, indexPath: indexPath)
            
        }
    }
    
    private func createCellForGeneral(with tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "personalAccountCell", for: indexPath) as! PersonalAccountTableViewCell
            cell.personalAccountButton.addTarget(self, action: #selector(openPersonalRepositories), for: .touchUpInside)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath) as! RepositoryTableViewCell
            guard let item = presenter.repositories[safe: indexPath.row] else { return cell }
            cell.setup(with: item)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func createCellForPersonal(with tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getNumberOfSections()
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

