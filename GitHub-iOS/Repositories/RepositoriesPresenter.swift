//
//  RepositoriesPresenter.swift
//  iOS-GitHub
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

public protocol TryingLogin: class {
    func successfulLogin()
}

protocol RepositoriesPresenterProtocol {
    var repositories: [RepositoryDTO] { get }
    var typeOfScreen: ScreenType { get set }
    func cancel()
    func search(with name: String)
    func openPersonalRepositories()
    func showRepositoryDetail(with repository: RepositoryDTO)
}

class RepositoriesPresenter: RepositoriesPresenterProtocol, TryingLogin {
    
    var view: RepositoriesViewControllerProtocol?
    var interactor: RepositoriesInteractorProtocol!
    var wireframe: RepositoriesWireframeProtocol!
    
    public var repositories : [RepositoryDTO] = []
    public var typeOfScreen: ScreenType = .general
    
    public func successfulLogin() {
        self.typeOfScreen = .personal
        self.view?.reload()
        getPersonalRepositories() 
    }
    
    public func search(with name: String) {
        
        interactor.searchRepositories(with: name) { [weak self] (repositories, error) in
            
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                if error == nil {
                    
                    guard let repo = repositories else {
                        return
                    }
                    
                    if repo.count == 0 {
                        return
                    }
                    self.repositories = repo
                    self.view?.reload()
                }
            }
        }
    }
    
    public func getPersonalRepositories() {
        
        interactor.getPersonalRepositories { [weak self] (repositories, error) in
            
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                if error == nil {
                    
                    guard let repo = repositories else {
                        self.getPersonalRepositories()
                        return
                    }
                    
                    if repo.count == 0 {
                        return
                    }
                    
                    self.repositories = repo
                    self.view?.reload()
                }
            }
        }
    }
    
    public func openPersonalRepositories() {
        if interactor.isUserLogged() {
            successfulLogin() 
            getPersonalRepositories()
        } else {
            wireframe!.showLogin(delegate: self)
        }
    }
    
    public func cancel() {
        DispatchQueue.main.async {
            self.repositories.removeAll()
            self.view?.reload()
        }
    }
    
    public func showRepositoryDetail(with repository: RepositoryDTO) {
        if repository.forksCount > 0 {
            wireframe.showRepositoryDetail(with: repository)
        }
    }
}
