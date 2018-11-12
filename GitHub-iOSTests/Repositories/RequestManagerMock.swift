//
//  RequestManagerMock.swift
//  GitHub-iOSTests
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@testable import GitHub_iOS

class RequestManagerMock: RequestManager {

    override func request<T>(url: String, method: HTTPMethod, parameters: [String : String]?, headers: [String : String]?, completionHandler: @escaping (T?, NSError?) -> Void) where T : Decodable {
        
        if url.contains("https://api.github.com/search/repositories?q=") {
            
            guard let data = loadJson("Repositories") else { fatalError("can't load the data")}
            
            let decoder = JSONDecoder()
            
            guard let items = try? decoder.decode(T.self , from: data) else {
                completionHandler(nil, NSError(domain: "Can't parse data for entity \(T.self)", code: 0))
                return
            }
            
            completionHandler(items, nil)
            
        } else if url.contains("https://api.github.com/repos/Datacup/dfhackscripts/forks") {
            
            guard let data = loadJson("Forks") else { fatalError("can't load the data")}
            
            let decoder = JSONDecoder()
            
            guard let items = try? decoder.decode(T.self , from: data) else {
                completionHandler(nil, NSError(domain: "Can't parse data for entity \(T.self)", code: 0))
                return
            }
            
            completionHandler(items, nil)
            
        } else if url.contains("https://api.github.com/users/anncherkes/repos") {
            
            guard let data = loadJson("PersonalRepository") else { fatalError("can't load the data")}
            
            let decoder = JSONDecoder()
            
            guard let items = try? decoder.decode(T.self , from: data) else {
                completionHandler(nil, NSError(domain: "Can't parse data for entity \(T.self)", code: 0))
                return
            }
            
            completionHandler(items, nil)
        }
        
    }
    
    private func loadJson(_ name: String) -> Data? {
        
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            fatalError("Missing file: Repos.json")
        }
        
        guard let json = try? Data(contentsOf: url) else {
            return nil
        }
        
        return json
    }
}
