//
//  NetworkService.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public let api_clientId = "fae95cb7b3ace1248836"
public let api_secretKey = "1e59623114892a4666820c3ce4539ac4ddd51427"

public enum NetworkServiceError: String {
    case networkDomain = "NetworkErrorDomain"
    case badResponceNetworkDomain = "BadResponceErrorDomain"
    case badObjectModelNetworkDomain = "BadObjectModelErrorDomain"
    case badUrlNetworkDomain = "BadUrlErrorDomain"
}

open class NetworkService: NSObject {
    
    public let requestManager: RequestManager
    public init(requestManager: RequestManager = Request()) {
        self.requestManager = requestManager
    }
}
