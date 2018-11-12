//
//  ForkNetworkManager.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

public protocol ForkNetworkManagerProtocol {
    func downloadForks(url: String, completionHandler: @escaping ([Fork]?, NSError?) -> Void)
}

public class ForkNetworkManager: NetworkService, ForkNetworkManagerProtocol {
    
    public func downloadForks(url: String, completionHandler: @escaping ([Fork]?, NSError?) -> Void) {
        requestManager.request(url: url, method: .get, parameters: nil) { (response: [Fork]?, error: NSError?) in
            completionHandler(response,error)
        }
    }
}
