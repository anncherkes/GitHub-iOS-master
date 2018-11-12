//
//  ForksDataManager.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

protocol ForksDataManagerProtocol {
    func downloadForks(url: String, completionHandler: @escaping ([ForkDTO]?, NSError?) -> Void)
}

public class ForksDataManager: NSObject, ForksDataManagerProtocol {
    
    private let forkNetworkManager: ForkNetworkManagerProtocol
    
     override init() {
        forkNetworkManager = ForkNetworkManager()
    }
    
    public func downloadForks(url: String, completionHandler: @escaping ([ForkDTO]?, NSError?) -> Void) {
        forkNetworkManager.downloadForks(url: url) { [weak self]  (forks, error) in
            
            guard let `self` = self else { return }
            
            if let items = forks {
                
                let forksMutated = self.mutated(items)
                completionHandler(forksMutated, nil)
            }
            completionHandler(nil, error)
        }
    }
    
    private func mutated(_ items: [Fork]) -> [ForkDTO] {
        var mutatedItems: [ForkDTO] = []
        for item in items {
            let repoItem = ForkDTO(item)
            mutatedItems.append(repoItem)
        }
        return mutatedItems
    }
}
