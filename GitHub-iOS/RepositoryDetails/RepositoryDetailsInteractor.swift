//
//  RepositoryDetailsInteractor.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

protocol RepositoryDetailsInteractorProtocol {
    func getForksInfo(completionHandler: @escaping ([ForkDTO]?, NSError?) -> Void)
    func getNameOfRepository () -> String?
}

class RepositoryDetailsInteractor: NSObject, RepositoryDetailsInteractorProtocol {

    private var dataManager: ForksDataManagerProtocol
    private var repository: RepositoryDTO
    
    init(_ repository: RepositoryDTO ) {
        self.dataManager = ForksDataManager()
        self.repository = repository
    }
    
    public func getNameOfRepository () -> String? {
        return repository.repositoryName
    }
    
    public func getForksInfo(completionHandler: @escaping ([ForkDTO]?, NSError?) -> Void) {
        
        guard let forksURL = repository.forksURL else { return }
        
        dataManager.downloadForks(url: forksURL) { (forks, error) in
            completionHandler(forks, error)
        }
    }
}
