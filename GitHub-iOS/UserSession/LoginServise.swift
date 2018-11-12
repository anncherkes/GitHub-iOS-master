//
//  LoginServise.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

public protocol LoginServiseProtocol {
    func isUserLogged() -> Bool
    func token() -> String?
    func login() -> String?
    func save(token: String?, login: String?)
}

public class LoginServise: NSObject, LoginServiseProtocol {
    
    private var userSession: UserSession!
    
    override init() {
        userSession = UserSession.sharedSession()
        super.init()
    }

    public func isUserLogged() -> Bool {
        
        if userSession.token != nil {
            return true
        } else { return false }
    }
    
    public func token() -> String? {
        return userSession.token
    }
    
    public func login() -> String? {
        return userSession.login
    }
    
    public func save(token: String?, login: String?) {
        
        if token != nil {
            userSession.token = token
            userSession.save()
        }
        
        if login != nil {
            userSession.login = login
            userSession.save()
        }
    }
}
