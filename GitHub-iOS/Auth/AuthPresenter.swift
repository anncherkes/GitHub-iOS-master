//
//  LoginPresenter.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

protocol LoginPresenterProtocol {
    func getLoginURL() -> URL?
    func login(with code: String)
    func checkURL (url: URL?) -> Bool
    func checkCode(code: String? ) -> Bool
}

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewControllerProtocol?
    var interactor: LoginInteractorProtocol!
    var wireframe: LoginWireframeProtocol!
    
    weak var delegate: TryingLogin?
    
    public func getLoginURL() -> URL?  {
        return interactor!.getLoginURL()
    }
    
    public func login(with code: String) {
        
        view?.startLoading()
        
        interactor.login(with: code) { [weak self] (user, error) in
            
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                
                self.view?.stopLoading()
                
                guard let _ = user else {
                    self.view?.close()
                    return
                }
                self.closeLoginWithSuccess()
            }
        }
    }
    
    private func closeLoginWithSuccess() {
        delegate?.successfulLogin()
        self.view?.close()
    }
    
    public func checkURL(url: URL?) -> Bool {
        
        if let urlUnwrapped = url, urlUnwrapped.host == getCallback() {
            return true
        } else {
            return false
        }
    }
    
    private func getCallback() -> String {
        return interactor.getCallback()
    }
    
    public func checkCode(code: String? ) -> Bool {
        if let codeNew = code {
            DispatchQueue.main.async {
                self.login(with: codeNew)
            }
            return true
        } else {
            return false
        }
    }
}
