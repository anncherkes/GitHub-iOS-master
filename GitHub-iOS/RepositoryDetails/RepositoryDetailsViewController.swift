//
//  RepositoryDetailsViewController.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit
import ANLoader

protocol RepositoryDetailsVCProtocol {
    func reload()
}

class RepositoryDetailsViewController: UITableViewController, RepositoryDetailsVCProtocol {

    var presenter: RepositoryDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter!.getForksInfo()
        self.title = presenter.getTitle()
    }
    
    public func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension RepositoryDetailsViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.forks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryDetail", for: indexPath) as! RepositoryDetailTableViewCell
        guard let item = presenter.forks[safe: indexPath.row] else { return cell }
        cell.setup(with: item)
        return cell
    }
}
