//
//  RequestManager.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON

public class RequestManager: NSObject {
    public func request<T:Decodable>(url: String, method: HTTPMethod, parameters: [String: String]?, headers:[String: String]? = nil, completionHandler: @escaping (T?, NSError?) -> Swift.Void) {
        completionHandler(nil, NSError(domain: "Base request haven't implementation", code: 404, userInfo: nil))
    }
    
    func cancelPrevious(url: String) { }
}

public class Request: RequestManager {
    
    private lazy var manager : Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 30
        return Alamofire.SessionManager(configuration: configuration)
    } ()
    
    public override func request<T:Decodable>(url: String, method: HTTPMethod, parameters: [String: String]?, headers:[String: String]? = nil, completionHandler: @escaping (T?, NSError?) -> Swift.Void) {
        
        manager.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(contentType: ["application/json"])
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        
                        let json = JSON(value)
                        
                        guard let data = try? json.rawData() else {
                            completionHandler(nil, NSError.init(domain: NetworkServiceError.badResponceNetworkDomain.rawValue, code: 0, userInfo: nil))
                            return
                        }
                        
                        let decoder = JSONDecoder()
                        
                        guard let items = try? decoder.decode(T.self , from: data) else {
                            completionHandler(nil, NSError(domain: "Can't parse data for entity \(T.self)", code: 0))
                            return
                        }
                        
                        completionHandler(items, nil)
                    }
                case .failure(let error):
                    completionHandler(nil, error as NSError?)
                }
        }
    }
    
    override func cancelPrevious(url: String) {
        manager.session.getAllTasks { (tasks) in
            tasks.forEach {
                if $0.originalRequest?.url?.absoluteString.contains(url) ?? false {  $0.cancel() }
            }
        }
    }
}
