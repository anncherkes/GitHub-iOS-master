//
//  RepositoryDetailsPresenter.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

protocol RepositoryDetailsPresenterProtocol {
    var forks: [ForkDTO] { get }
    func getForksInfo()
    func getTitle() -> String?
}

class RepositoryDetailsPresenter: RepositoryDetailsPresenterProtocol {
    
    var view: RepositoryDetailsVCProtocol?
    var interactor: RepositoryDetailsInteractorProtocol!
    var wireframe: RepositoryDetailsWireframeProtocol!
    
    public var forks: [ForkDTO] = []
    
    public func getTitle() -> String? {
        return interactor.getNameOfRepository()
    }
    
    public func getForksInfo() {
        
        interactor.getForksInfo { [weak self] (items, error) in
            
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                if error == nil {
                    
                    guard let forks = items else {
                        return
                    }
                    
                    if forks.count == 0 {
                        return
                    }
                    
                    self.forks = forks
                    self.view?.reload()
                    
                }
            }
            
        }
    }
}
