//
//  RepositoriesDataManager.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

public protocol RepositoriesDataManagerProtocol {
    func getPersonalRepositories(completionHandler: @escaping ([RepositoryDTO]?, NSError?) -> Void)
    func getRepositories(with name: String, completionHandler: @escaping ([RepositoryDTO]?, NSError?) -> Void)
}

public class RepositoriesDataManager: NSObject, RepositoriesDataManagerProtocol {

    private var network: RepositoriesNetworkManagerProtocol
    private var loginServise: LoginServise = LoginServise()

    override init() {
        network = RepositoriesNetworkManager()
    }
    
    public func setNetwork(_ network: RepositoriesNetworkManager, loginServise: LoginServiseProtocol ) {
        self.network = network
        self.loginServise.save(token: nil, login: loginServise.login())
    }
    
    public func getPersonalRepositories( completionHandler: @escaping ([RepositoryDTO]?, NSError?) -> Void) {
        
        guard let login = loginServise.login() else {
            completionHandler(nil, NSError(domain: "You must be loginned", code: 0, userInfo: nil))
            return
        }
        
        network.getPersonalRepositories(login: login) { [weak self] (repositories, error) in
            
            guard let `self` = self else { return }
            
            if let repo = repositories {
                let repositoriesMutated =  self.mutated( repo)
                completionHandler(repositoriesMutated, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    public func getRepositories(with name: String, completionHandler: @escaping ([RepositoryDTO]?, NSError?) -> Void) {
        
        network.getRepositories(with: name) { [weak self] (repositories, error) in
            
            guard let `self` = self else { return }
            
            if let repo = repositories {
                let repositoriesMutated = self.mutated(repo.items)
                completionHandler(repositoriesMutated, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    private func mutated(_ items: [RepositoryItem]?) -> [RepositoryDTO] {
        guard let repositories = items else { return [] }
        
        var mutatedItems: [RepositoryDTO] = []
        for item in repositories {
            let repoItem = RepositoryDTO(item)
            mutatedItems.append(repoItem)
        }
        return mutatedItems
    }
}

