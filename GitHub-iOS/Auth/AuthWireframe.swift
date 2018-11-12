//
//  LoginWireframe.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit
protocol LoginWireframeProtocol: BaseWireframe {
    
}

class LoginWireframe: LoginWireframeProtocol {
    
    var navigationController: UINavigationController!

    func build(data: AnyObject?) -> UIViewController {

        let viewController = showLoginFromStoryboard()
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        
        viewController.presenter = presenter
        
        if let delegate = data as? TryingLogin {
            presenter.delegate = delegate
        }

        presenter.wireframe = self
        presenter.interactor = interactor
        presenter.view = viewController
        
        return viewController
    }
    
    private func showLoginFromStoryboard() -> LoginViewController {
        let vc = UIStoryboard(name: "Auth", bundle:nil).instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        return vc
    }

}
