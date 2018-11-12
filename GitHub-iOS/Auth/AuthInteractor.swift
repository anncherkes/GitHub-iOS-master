//
//  LoginInteractor.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

protocol LoginInteractorProtocol {
    func getLoginURL() -> URL?
    func login(with code: String, completionHandler: @escaping (String?, NSError?) -> Void)
    func getCallback() -> String
}

class LoginInteractor: NSObject, LoginInteractorProtocol {
    
    private let dataManager: LoginDataManagerProtocol
    
    override init() {
        dataManager = LoginDataManager()
    }
    public func getLoginURL() -> URL? {
        return dataManager.getLoginURL()
    }
    
    public func login(with code: String, completionHandler: @escaping (String?, NSError?) -> Void) {
        dataManager.login(code: code) { (login, error) in
            completionHandler(login, error)
        }
    }
    
    public func getCallback() -> String {
        return "mycallback.com"
    }
}

