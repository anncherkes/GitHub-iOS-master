//
//  LoginDataManager.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import Foundation

public protocol LoginDataManagerProtocol {
    func getLoginURL() -> URL?
    func login(code: String, completionHandler: @escaping (String?, NSError?) -> Void)
}

public class LoginDataManager: LoginDataManagerProtocol {
    
    private let network: LoginNetworkManager = LoginNetworkManager()
    private let loginServise: LoginServise = LoginServise()
    
    public func getLoginURL() -> URL? {
        return URL(string: "https://github.com/login/oauth/authorize?client_id=\(api_clientId)")
    }
    
    public func login(code: String, completionHandler: @escaping (String?, NSError?) -> Void) {
        
        if loginServise.isUserLogged() {
            completionHandler(loginServise.token(), nil)
            return
        }
        
        downloadUser(code: code) { (user, error) in
            if let userUnwrapped = user {
                completionHandler(userUnwrapped.login, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    private func downloadUser(code: String, completionHandler: @escaping (UserDTO?, NSError?) -> Void) {
        
        if loginServise.isUserLogged() {
            return
        }
        network.downloadAccessToken(code: code) { [weak self] (accessToken, error) in
            
            guard let `self` = self else { return }
            guard let token = accessToken else {
                completionHandler(nil, error)
                return
            }
            self.loginServise.save(token: token, login: nil)
            self.network.getUser(accessToken: token, completionHandler: { [weak self] (userDecodable, error) in
                if let userDecodableUnwrapped = userDecodable {
                    let user = UserDTO(userDecodableUnwrapped)
                    guard let `self` = self else { return }
                    
                    if let login = user.login {
                        self.loginServise.save(token: nil, login: login)
                    }
                    completionHandler(user, error)
                }
            })
        }
    }
}


