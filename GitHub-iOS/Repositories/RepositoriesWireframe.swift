//
//  RepositoriesWireframe.swift
//  iOS-GitHub
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

public enum ScreenType {
    case general
    case personal
}

protocol RepositoriesWireframeProtocol: BaseWireframe {
    func showLogin(delegate: TryingLogin?)
    func showRepositoryDetail(with repository: RepositoryDTO) 
}

class RepositoriesWireframe: RepositoriesWireframeProtocol {
    
    var navigationController: UINavigationController!

    func build(data: AnyObject?) -> UIViewController {
    
        let viewController = createRepositoriesFromStoryboard()
        let presenter = RepositoriesPresenter()
        let interactor = RepositoriesInteractor()
        
        viewController.presenter = presenter
                
        presenter.wireframe = self
        presenter.interactor = interactor
        presenter.view = viewController
        
        return viewController
    }
    
    private func createRepositoriesFromStoryboard() -> RepositoriesViewController {
        let storyboard = UIStoryboard.init(name: "Repositories", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "repositoriesVC") as! RepositoriesViewController
        return viewController
    }
    
    public func showLogin(delegate: TryingLogin?) {
        var wireframe: LoginWireframeProtocol = LoginWireframe()
        let vc = wireframe.build(data: delegate as AnyObject)
        let loginNavigationController = UINavigationController(rootViewController: vc)
        wireframe.navigationController = loginNavigationController
        loginNavigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(loginNavigationController, animated: true, completion: nil)
    }
    
    public func showRepositoryDetail(with repository: RepositoryDTO) {
        var wireframe: RepositoryDetailsWireframeProtocol = RepositoryDetailsWireframe()
        let vc = wireframe.build(data: repository)
        wireframe.navigationController = self.navigationController
        self.navigationController.show(vc, sender: nil)
    }
}
