//
//  RepositoriesInteractor.swift
//  iOS-GitHub
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

protocol RepositoriesInteractorProtocol {
    func isUserLogged() -> Bool
    func getPersonalRepositories(completionHandler: @escaping ([RepositoryDTO]?, NSError?) -> Void)
    func searchRepositories(with name: String, completionHandler: @escaping ([RepositoryDTO]?, NSError?) -> Void)
}

class RepositoriesInteractor: NSObject, RepositoriesInteractorProtocol {
    
    private var loginServise: LoginServise = LoginServise()
    private var dataManager: RepositoriesDataManagerProtocol
    
    override init() {
        dataManager = RepositoriesDataManager()
    }
    
    public func isUserLogged() -> Bool {
        return loginServise.isUserLogged()
    }
    
    public func getPersonalRepositories(completionHandler: @escaping ([RepositoryDTO]?, NSError?) -> Void) {
        dataManager.getPersonalRepositories() { (repositories, error) in
            completionHandler(repositories, error)
        }
    }
    
    public func searchRepositories(with name: String, completionHandler: @escaping ([RepositoryDTO]?, NSError?) -> Void) {
        dataManager.getRepositories(with: name) { (items, error) in
            completionHandler(items, error)
        }
    }
}
