//
//  AuthorizationNetwork.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit
import Alamofire

public protocol LoginNetworkManagerProtocol {
    func downloadAccessToken(code: String, completionHandler: @escaping (String?, NSError?) -> Void)
    func getUser(accessToken: String, completionHandler: @escaping (User?, NSError?) -> Void)
}

public class LoginNetworkManager: NetworkService, LoginNetworkManagerProtocol {
    
    public func downloadAccessToken(code: String, completionHandler: @escaping (String?, NSError?) -> Void) {
        
        let url = "https://github.com/login/oauth/access_token"
        let parameters = ["client_id" : api_clientId,
                          "client_secret" : api_secretKey,
                          "code" : code]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        requestManager.request(url: url, method: .post, parameters: parameters, headers: headers) { (auth: Authorization?, error: NSError?) in
            completionHandler(auth?.access_token, error)
        }
    }
    
    public func getUser(accessToken: String, completionHandler: @escaping (User?, NSError?) -> Void) {
        
        let url = "https://api.github.com/user"
        let headers: HTTPHeaders = [
            "Authorization": "token \(accessToken)",
            "Accept": "application/json"
        ]
        requestManager.request(url: url, method: .get, parameters: nil, headers: headers) { (user: User?, error: NSError?) in
            completionHandler(user, error)
        }
    }
}
