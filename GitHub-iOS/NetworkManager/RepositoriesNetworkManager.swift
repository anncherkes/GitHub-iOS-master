//
//  RepositoriesNetworkManager.swift
//  GitHub-iOS
///Users/annacherkes/Desktop/GitHub-iOS/GitHub-iOS/AppDelegate.swift
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

public protocol RepositoriesNetworkManagerProtocol {
    func getPersonalRepositories(login: String, completionHandler: @escaping ([RepositoryItem]?, NSError?) -> Void)
    func getRepositories(with name: String, completionHandler: @escaping (Repository?, NSError?) -> Void) 
}

public class RepositoriesNetworkManager: NetworkService, RepositoriesNetworkManagerProtocol {
    
    public func getRepositories(with name: String, completionHandler: @escaping (Repository?, NSError?) -> Void) {

        guard let query = name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            completionHandler(nil, NSError.init(domain: NetworkServiceError.badUrlNetworkDomain.rawValue, code: 0, userInfo: nil))
            return
        }
        let url = "https://api.github.com/search/repositories?q=\(query)"

        requestManager.cancelPrevious(url: "https://api.github.com/search/repositories?q=")

        requestManager.request(url: url, method: .get, parameters: nil) { (repo: Repository?, error: NSError?) in
            completionHandler(repo, error)
        }
    }
    
    public func getPersonalRepositories(login: String, completionHandler: @escaping ([RepositoryItem]?, NSError?) -> Void) {
        
        let url = "https://api.github.com/users/\(login)/repos"
        requestManager.request(url: url, method: .get, parameters: nil) { (response: [RepositoryItem]?, error: NSError?) in
            completionHandler(response, error)
        }
    }
}
