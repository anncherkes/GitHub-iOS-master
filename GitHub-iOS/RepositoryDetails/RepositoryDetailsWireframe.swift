//
//  RepositoryDetailsWireframe.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

protocol RepositoryDetailsWireframeProtocol: BaseWireframe  {
    
}

class RepositoryDetailsWireframe: RepositoryDetailsWireframeProtocol {
    
    var navigationController: UINavigationController!
    
    func build(data: AnyObject?) -> UIViewController {
        
        guard let repository = data as? RepositoryDTO else { fatalError("You must set selected repositoryt") }
        let viewController = createRepositoryDetailsFromStoryboard()
        let presenter = RepositoryDetailsPresenter()
        let interactor = RepositoryDetailsInteractor(repository)

        viewController.presenter = presenter
        
        presenter.wireframe = self
        presenter.interactor = interactor
        presenter.view = viewController
        
        return viewController
    }
    
    private func createRepositoryDetailsFromStoryboard() -> RepositoryDetailsViewController {
        
        let storyboard = UIStoryboard.init(name: "RepositoryDetails", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "repositoryDetailsVC") as! RepositoryDetailsViewController
        return viewController
    }
}
