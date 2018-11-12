//
//  File.swift
//  iOS-GitHub
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

public protocol BaseWireframe {
    func build(data: AnyObject?) -> UIViewController
    var navigationController: UINavigationController! { set get }
}

class LoadingWireframe: NSObject {
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        
        window.rootViewController = loadRepositories(window: window)
        window.makeKeyAndVisible()
    }
    
    private func loadRepositories(window: UIWindow) -> UIViewController {
    
        var wireframe: RepositoriesWireframeProtocol = RepositoriesWireframe()
        let navigationController = UINavigationController(rootViewController: wireframe.build(data: nil))
        wireframe.navigationController = navigationController
        return navigationController
    }
}
